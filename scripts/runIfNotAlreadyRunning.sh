#!/bin/sh

command=$1

echo $command

if ! pidof -x $(basename $command) > /dev/null; then
    $command &
fi
