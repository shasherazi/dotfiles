local mainMod = "SUPER"
local terminal = "kitty"
local browser = "firefox"
local files = "dolphin"

local function bind(keys, dispatcher, ...)
  hl.bind(mainMod .. " + " .. keys, dispatcher, ...)
end

-- launchers
bind("Return", hl.dsp.exec_cmd(terminal))
bind("SHIFT + Return", hl.dsp.exec_cmd(terminal .. " -e tmux"))
bind("B", hl.dsp.exec_cmd(browser))
bind("N", hl.dsp.exec_cmd(files))
bind("SHIFT + C", hl.dsp.window.close())

-- scripts
bind("Q", hl.dsp.exec_cmd("~/dotfiles/scripts/qr.sh"))
bind("K", hl.dsp.exec_cmd("~/dotfiles/scripts/kill_menu.sh"))
bind("SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
bind("SPACE", hl.dsp.exec_cmd("rofi -show drun"))
bind("V",
  hl.dsp.exec_cmd(
    'cliphist list | rofi -dmenu -p "Copy:" -config "~/.config/rofi/clipboard.rasi" | cliphist decode | wl-copy'))
bind("E",
  hl.dsp.exec_cmd(
    [[cat /home/shasherazi/dotfiles/assets/files/emojis.txt | rofi -dmenu -i -p "Search emoji:" -config "~/.config/rofi/emoji.rasi" | awk '{printf "%s", $1}' | wl-copy]]))
bind("W", hl.dsp.exec_cmd("~/dotfiles/scripts/wallpaper_picker.sh"))
bind("SHIFT + W", hl.dsp.exec_cmd("~/dotfiles/scripts/randomWallpaperSelector.sh"))

-- window management
bind("Tab", hl.dsp.focus({ workspace = "previous" }))
bind("F", hl.dsp.window.fullscreen({ "fullscreen", "toggle" }))

-- Move focus with mainMod + arrow keys
bind("left", hl.dsp.focus({ direction = "left" }))
bind("right", hl.dsp.focus({ direction = "right" }))
bind("up", hl.dsp.focus({ direction = "up" }))
bind("down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  bind(key, hl.dsp.focus({ workspace = i }))
  bind("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
bind("mouse:272", hl.dsp.window.drag(), { mouse = true })
bind("mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
bind("T", hl.dsp.window.float({ action = "toggle" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- screenshot
hl.bind("Print",
  hl.dsp.exec_cmd(
    [[if area=$(slurp); then grim -g "$area" - | tee >(wl-copy) > ~/pictures/screenshots/screenshot_$(date +%y%m%d-%h%m%s).png && dunstify "screenshot of the region taken" -t 1000; fi]]))
hl.bind("SHIFT + Print",
  hl.dsp.exec_cmd(
    [[grim - | wl-copy && wl-paste > ~/Pictures/screenshots/screenshot_$(date +%Y%m%d-%H%M%S).png && dunstify "Screenshot of whole screen taken" -t 1000]]))
