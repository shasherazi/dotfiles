curl -L -C - https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip --output JetBrainsMono.zip &&
    mkdir -p ~/.fonts && echo "created ~/.fonts" &&
    cp JetBrainsMono.zip ~/.fonts/ && echo "copied to ~/.fonts" &&
    unzip -o ~/.fonts/JetBrainsMono.zip -d ~/.fonts/ && echo "unzipped to ~/.fonts" &&
    rm ~/.fonts/JetBrainsMono.zip && echo "removed ~/.fonts/JetBrainsMono.zip" &&
    fc-cache -f -v && echo "ran fc-cache -f -v"
