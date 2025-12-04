#!/bin/sh

gpg --full-generate-key
KEY_ID=$(gpg --list-secret-keys --keyid-format=long | grep -A 1 "sec" | tail -n 1 | awk '{print $1}')
gpg --armor --export $KEY_ID

git config --global --unset gpg.format
git config --global user.signingkey $KEY_ID

git config --global commit.gpgsign true
git config --global tag.gpgSign true
