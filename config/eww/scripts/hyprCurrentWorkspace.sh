#!/bin/sh

# Get the current workspace
workspace=$(hyprctl monitors | grep active | awk '{print $3}')

# Print the current workspace
echo $workspace

# check if workspace changed in a loop
while true; do
	# Get the current workspace
	newWorkspace=$(hyprctl monitors | grep active | awk '{print $3}')

	# Check if the workspace changed
	if [ "$workspace" != "$newWorkspace" ]; then
		# Print the new workspace
		echo $newWorkspace

		# Update the workspace
		workspace=$newWorkspace
	fi
done
