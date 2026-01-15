#!/bin/sh

ssh-keygen -t ed25519 -C "hassanrandomz@gmail.com"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
