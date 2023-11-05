#!/bin/sh

workspaces=$(hyprctl workspaces | grep -o 'workspace ID [0-9]*' | awk '{print $3}' | sort -n | jq -cs '[.[] | tonumber]')

echo $workspaces

# check if workspaces change in a loop
while true; do
	new_workspaces=$(hyprctl workspaces | grep -o 'workspace ID [0-9]*' | awk '{print $3}' | sort -n | jq -cs '[.[] | tonumber]')
	if [ "$workspaces" != "$new_workspaces" ]; then
		workspaces=$new_workspaces
		echo "$workspaces"
	fi
done
