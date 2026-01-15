#!/usr/bin/env bash

# Configuration file path
MONITORS_CONF="$HOME/.config/hypr/monitors.conf"

# Get monitor information and parse it
get_monitors() {
    local monitors_output
    local monitor_entries=()
    local current_monitor=""
    local current_description=""
    local line_count=0
    local in_monitor_block=false
    
    # Get hyprctl output
    monitors_output=$(hyprctl monitors all)
    
    # Parse the output line by line
    while IFS= read -r line; do
        # Check if line starts with "Monitor " - this indicates a new monitor
        if [[ $line =~ ^Monitor\ ([^\ ]+) ]]; then
            # If we were processing a previous monitor and it's not the first one, add it
            if [ $in_monitor_block = true ] && [ $line_count -gt 1 ]; then
                if [ -n "$current_description" ]; then
                    monitor_entries+=("$current_monitor|$current_description")
                else
                    monitor_entries+=("$current_monitor|No description")
                fi
            fi
            
            # Start processing new monitor
            current_monitor="${BASH_REMATCH[1]}"
            current_description=""
            ((line_count++))
            in_monitor_block=true
            
        # Look for description line
        elif [[ $line =~ ^[[:space:]]*description:[[:space:]]*(.+)$ ]] && [ $in_monitor_block = true ]; then
            current_description="${BASH_REMATCH[1]}"
        fi
    done <<< "$monitors_output"
    
    # Don't forget the last monitor if it's not the first one
    if [ $in_monitor_block = true ] && [ $line_count -gt 1 ]; then
        if [ -n "$current_description" ]; then
            monitor_entries+=("$current_monitor|$current_description")
        else
            monitor_entries+=("$current_monitor|No description")
        fi
    fi
    
    # Output the monitor entries
    printf '%s\n' "${monitor_entries[@]}"
}

# Get ALL monitors (including the first one) for mirroring options
get_all_monitors() {
    local monitors_output
    local monitor_entries=()
    local current_monitor=""
    local current_description=""
    local in_monitor_block=false
    
    # Get hyprctl output
    monitors_output=$(hyprctl monitors all)
    
    # Parse the output line by line
    while IFS= read -r line; do
        # Check if line starts with "Monitor " - this indicates a new monitor
        if [[ $line =~ ^Monitor\ ([^\ ]+) ]]; then
            # If we were processing a previous monitor, add it
            if [ $in_monitor_block = true ]; then
                if [ -n "$current_description" ]; then
                    monitor_entries+=("$current_monitor|$current_description")
                else
                    monitor_entries+=("$current_monitor|No description")
                fi
            fi
            
            # Start processing new monitor
            current_monitor="${BASH_REMATCH[1]}"
            current_description=""
            in_monitor_block=true
            
        # Look for description line
        elif [[ $line =~ ^[[:space:]]*description:[[:space:]]*(.+)$ ]] && [ $in_monitor_block = true ]; then
            current_description="${BASH_REMATCH[1]}"
        fi
    done <<< "$monitors_output"
    
    # Don't forget the last monitor
    if [ $in_monitor_block = true ]; then
        if [ -n "$current_description" ]; then
            monitor_entries+=("$current_monitor|$current_description")
        else
            monitor_entries+=("$current_monitor|No description")
        fi
    fi
    
    # Output the monitor entries
    printf '%s\n' "${monitor_entries[@]}"
}

# Get available resolutions for a specific monitor
get_monitor_resolutions() {
    local monitor_id="$1"
    local resolutions=()
    
    # Get the specific monitor info and extract available modes
    local monitor_info=$(hyprctl monitors all | grep -A 50 "Monitor $monitor_id")
    
    # Look for the availableModes line
    local modes_line=$(echo "$monitor_info" | grep "availableModes:" | sed 's/.*availableModes: //')
    
    if [ -n "$modes_line" ]; then
        # Parse individual modes - they're separated by spaces
        while read -r mode; do
            if [[ $mode =~ ^[0-9]+x[0-9]+@[0-9]+\.[0-9]+Hz$ ]]; then
                # Remove Hz suffix
                local resolution=$(echo "$mode" | sed 's/Hz$//')
                resolutions+=("$resolution")
            fi
        done <<< "$(echo "$modes_line" | tr ' ' '\n')"
    fi
    
    # Always provide special values first, then any parsed resolutions
    {
        echo "preferred"
        echo "highres" 
        echo "highrr"
        echo "maxwidth"
        printf '%s\n' "${resolutions[@]}"
    }
}

# Check if monitor is currently mirroring
is_mirroring() {
    local monitor_desc="$1"
    
    if [ -f "$MONITORS_CONF" ] && grep -q "desc:$monitor_desc" "$MONITORS_CONF"; then
        local config_line=$(grep "desc:$monitor_desc" "$MONITORS_CONF")
        if [[ $config_line == *"mirror"* ]]; then
            return 0  # Is mirroring
        fi
    fi
    return 1  # Not mirroring
}

# Get what monitor is being mirrored
get_mirrored_monitor() {
    local monitor_desc="$1"
    
    if [ -f "$MONITORS_CONF" ] && grep -q "desc:$monitor_desc" "$MONITORS_CONF"; then
        local config_line=$(grep "desc:$monitor_desc" "$MONITORS_CONF")
        if [[ $config_line == *"mirror"* ]]; then
            # Extract the mirrored monitor name (after "mirror, ")
            echo "$config_line" | sed -n 's/.*mirror, *\([^, #]*\).*/\1/p'
        fi
    fi
}

# Update specific parameter in monitor configuration
update_monitor_parameter() {
    local monitor_id="$1"
    local monitor_desc="$2"
    local parameter="$3"
    local new_value="$4"
    
    # Create monitors.conf if it doesn't exist
    if [ ! -f "$MONITORS_CONF" ]; then
        mkdir -p "$(dirname "$MONITORS_CONF")"
        touch "$MONITORS_CONF"
    fi
    
    # Get current configuration or set defaults
    local current_resolution="preferred"
    local current_position="auto"
    local current_scale="1.0"
    local current_mirror=""
    
    # Parse existing configuration if it exists
    if grep -q "desc:$monitor_desc" "$MONITORS_CONF"; then
        local current_line=$(grep "desc:$monitor_desc" "$MONITORS_CONF")
        # Extract parameters: monitor = desc:..., resolution, position, scale[, mirror, target]
        current_resolution=$(echo "$current_line" | cut -d',' -f2 | xargs)
        current_position=$(echo "$current_line" | cut -d',' -f3 | xargs)
        current_scale=$(echo "$current_line" | cut -d',' -f4 | xargs)
        
        # Check if there's mirroring
        if [[ $current_line == *"mirror"* ]]; then
            current_mirror=$(get_mirrored_monitor "$monitor_desc")
        fi
        
        # Clean scale field (remove everything after # or mirror)
        current_scale=$(echo "$current_scale" | sed 's/#.*//' | sed 's/mirror.*//' | xargs)
    fi
    
    # Update the specific parameter
    case "$parameter" in
        "resolution")
            current_resolution="$new_value"
            ;;
        "position")
            current_position="$new_value"
            ;;
        "scale")
            current_scale="$new_value"
            ;;
        "mirror")
            current_mirror="$new_value"
            ;;
        "unmirror")
            current_mirror=""
            ;;
    esac
    
    # Create the new monitor line
    local monitor_line="monitor = desc:$monitor_desc, $current_resolution, $current_position, $current_scale"
    
    # Add mirror if specified
    if [ -n "$current_mirror" ]; then
        monitor_line="$monitor_line, mirror, $current_mirror"
    fi
    
    # Add comment with monitor ID
    monitor_line="$monitor_line # $monitor_id"
    
    # Update or add the configuration
    if grep -q "desc:$monitor_desc" "$MONITORS_CONF"; then
        # Update existing line
        sed -i "/desc:$monitor_desc/c\\$monitor_line" "$MONITORS_CONF"
        echo "Updated $parameter for monitor: $monitor_desc"
    else
        # Add new line
        echo "$monitor_line" >> "$MONITORS_CONF"
        echo "Added configuration for monitor: $monitor_desc"
    fi
    
    # Reload Hyprland configuration
    hyprctl reload
}

# Show configuration options menu
show_config_options() {
    local monitor_desc="$1"
    
    local options=(
        "Resolution"
        "Position"
        "Scale"
    )
    
    # Add mirror/unmirror option
    if is_mirroring "$monitor_desc"; then
        local mirrored_monitor=$(get_mirrored_monitor "$monitor_desc")
        options+=("Unmirror (currently: $mirrored_monitor)")
    else
        options+=("Mirror")
    fi
    
    printf '%s\n' "${options[@]}" | rofi -dmenu -p "Configure:" -theme-str 'window {width: 400px;}'
}

# Get available monitors (excluding first one)
available_monitors=$(get_monitors)

# Check if there are any external monitors
if [ -z "$available_monitors" ]; then
    echo "No external monitors detected"
    exit 1
fi

# Convert for rofi display (replace | with readable separator)
display_monitors=$(echo "$available_monitors" | sed 's/|/ | /')

# Show rofi menu for monitor selection
selected_entry=$(echo "$display_monitors" | rofi -dmenu -p "Select Monitor:" -theme-str 'window {width: 600px;}')

# Check if user made a selection
if [ -z "$selected_entry" ]; then
    echo "No monitor selected"
    exit 0
fi

# Extract monitor ID and description from the selection
selected_monitor=$(echo "$selected_entry" | cut -d'|' -f1 | xargs)
selected_description=$(echo "$selected_entry" | cut -d'|' -f2 | xargs)

echo "Selected monitor: $selected_monitor ($selected_description)"

# Show configuration options menu
config_option=$(show_config_options "$selected_description")

# Check if user made a selection
if [ -z "$config_option" ]; then
    echo "No configuration option selected"
    exit 0
fi

case "$config_option" in
    "Resolution")
        echo "Getting available resolutions..."
        available_resolutions=$(get_monitor_resolutions "$selected_monitor")
        selected_value=$(echo "$available_resolutions" | rofi -dmenu -p "Select Resolution:" -theme-str 'window {width: 400px;}')
        
        if [ -n "$selected_value" ]; then
            update_monitor_parameter "$selected_monitor" "$selected_description" "resolution" "$selected_value"
        fi
        ;;
        
    "Position")
        positions=(
            "auto"
            "auto-left"
            "auto-right" 
            "auto-up"
            "auto-down"
            "auto-center-left"
            "auto-center-right"
            "auto-center-up" 
            "auto-center-down"
        )
        selected_value=$(printf '%s\n' "${positions[@]}" | rofi -dmenu -p "Select Position:" -theme-str 'window {width: 400px;}')
        
        if [ -n "$selected_value" ]; then
            update_monitor_parameter "$selected_monitor" "$selected_description" "position" "$selected_value"
        fi
        ;;
        
    "Scale")
        scales=("0.5" "1.0" "1.5" "2.0")
        selected_value=$(printf '%s\n' "${scales[@]}" | rofi -dmenu -p "Select Scale:" -theme-str 'window {width: 300px;}')
        
        if [ -n "$selected_value" ]; then
            update_monitor_parameter "$selected_monitor" "$selected_description" "scale" "$selected_value"
        fi
        ;;
    
    "Mirror")
        # Get all monitors except the selected one
        all_monitors=$(get_all_monitors)
        available_mirror_targets=""
        
        while IFS= read -r monitor_entry; do
            monitor_id=$(echo "$monitor_entry" | cut -d'|' -f1)
            if [ "$monitor_id" != "$selected_monitor" ]; then
                available_mirror_targets+="$monitor_entry"$'\n'
            fi
        done <<< "$all_monitors"
        
        # Remove trailing newline
        available_mirror_targets=$(echo "$available_mirror_targets" | sed '/^$/d')
        
        if [ -z "$available_mirror_targets" ]; then
            echo "No other monitors available for mirroring"
            exit 1
        fi
        
        # Convert for rofi display
        display_mirror_targets=$(echo "$available_mirror_targets" | sed 's/|/ | /')
        
        selected_mirror_entry=$(echo "$display_mirror_targets" | rofi -dmenu -p "Mirror which monitor:" -theme-str 'window {width: 600px;}')
        
        if [ -n "$selected_mirror_entry" ]; then
            mirror_target=$(echo "$selected_mirror_entry" | cut -d'|' -f1 | xargs)
            update_monitor_parameter "$selected_monitor" "$selected_description" "mirror" "$mirror_target"
        fi
        ;;
        
    "Unmirror"*)
        update_monitor_parameter "$selected_monitor" "$selected_description" "unmirror" ""
        ;;
esac
