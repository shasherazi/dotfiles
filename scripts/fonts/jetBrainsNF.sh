rm JetBrainsMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip
mkdir ~./.fonts
mv JetBrainsMono.zip ~/.fonts/
unzip ~/.fonts/JetBrainsMono.zip -d ~/.fonts/
rm ~/.fonts/JetBrainsMono.zip
fc-cache -f -v
