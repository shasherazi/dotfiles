#!/bin/sh

command=$1

if ! pgrep -u $USER $command >/dev/null 2>&1; then
    exec $command
fi
