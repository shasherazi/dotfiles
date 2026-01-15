#!/bin/bash

set -e

# 1. Find the latest Cemu AppImage in ~/Downloads
APPIMAGE=$(ls -t ~/Downloads/Cemu-*-x86_64.AppImage 2>/dev/null | head -n 1)

if [[ ! -f "$APPIMAGE" ]]; then
    echo "No Cemu AppImage found in ~/Downloads."
    exit 1
fi

echo "Found AppImage: $APPIMAGE"

# 2. Move to /opt
sudo mkdir -p /opt/Cemu
sudo cp "$APPIMAGE" /opt/Cemu/cemu.AppImage
sudo chmod +x /opt/Cemu/cemu.AppImage

# 3. Create symlink in /usr/local/bin
sudo ln -sf /opt/Cemu/cemu.AppImage /usr/local/bin/cemu

# 4. Download icon if not present
ICON_DIR="$HOME/.local/share/icons"
ICON_PATH="$ICON_DIR/cemu.png"
if [[ ! -f "$ICON_PATH" ]]; then
    mkdir -p "$ICON_DIR"
    curl -L https://avatars.githubusercontent.com/u/40145098 -o "$ICON_PATH"
fi

# 5. Create desktop entry
DESKTOP_FILE="$HOME/.local/share/applications/cemu.desktop"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Cemu
Comment=Wii U Emulator
Exec=/opt/Cemu/cemu.AppImage
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Game;Emulator;
EOF

echo "Cemu AppImage installed!"
echo "You can now run 'cemu' from the terminal or find it in your application menu."
