#!/usr/bin/sh

if  (ps -aux | grep picom | grep -v "grep" )
then
  echo "Picom found"
  pkill -9 picom
else
  echo "Picom not found"
  picom -b 
fi

