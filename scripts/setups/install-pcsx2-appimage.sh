#!/bin/bash

set -e

# 1. Find the latest PCSX2 AppImage in ~/Downloads
APPIMAGE=$(ls -t ~/Downloads/pcsx2-v*-linux-appimage-x64-Qt.AppImage 2>/dev/null | head -n 1)

if [[ ! -f "$APPIMAGE" ]]; then
    echo "No PCSX2 AppImage found in ~/Downloads."
    exit 1
fi

echo "Found AppImage: $APPIMAGE"

# 2. Move to /opt
sudo mkdir -p /opt/PCSX2
sudo cp "$APPIMAGE" /opt/PCSX2/pcsx2.AppImage
sudo chmod +x /opt/PCSX2/pcsx2.AppImage

# 3. Create symlink in /usr/local/bin
sudo ln -sf /opt/PCSX2/pcsx2.AppImage /usr/local/bin/pcsx2

# 4. Download icon if not present
ICON_DIR="$HOME/.local/share/icons"
ICON_PATH="$ICON_DIR/pcsx2.png"
if [[ ! -f "$ICON_PATH" ]]; then
    mkdir -p "$ICON_DIR"
    curl -L https://avatars.githubusercontent.com/u/93534913?v=4 -o "$ICON_PATH"
fi

# 5. Create desktop entry
DESKTOP_FILE="$HOME/.local/share/applications/pcsx2.desktop"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=PCSX2
Comment=PlayStation 2 Emulator
Exec=/opt/PCSX2/pcsx2.AppImage
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Game;Emulator;
EOF

echo "PCSX2 AppImage installed!"
echo "You can now run 'pcsx2' from the terminal or find it in your application menu."
