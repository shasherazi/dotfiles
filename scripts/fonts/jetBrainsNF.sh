curl -L -C - https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip --output JetBrainsMono.zip &&
    mkdir -p ~/.fonts &&
    cp JetBrainsMono.zip ~/.fonts/ &&
    unzip -o ~/.fonts/JetBrainsMono.zip -d ~/.fonts/ &&
    rm ~/.fonts/JetBrainsMono.zip &&
    fc-cache -f -v
