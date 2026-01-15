#!/bin/bash

set -e

# 1. Find the latest DuckStation AppImage in ~/Downloads
APPIMAGE=$(ls -t ~/Downloads/DuckStation-x64.AppImage 2>/dev/null | head -n 1)

if [[ ! -f "$APPIMAGE" ]]; then
    echo "No DuckStation AppImage found in ~/Downloads."
    exit 1
fi

echo "Found AppImage: $APPIMAGE"

# 2. Move to /opt
sudo mkdir -p /opt/DuckStation
sudo cp "$APPIMAGE" /opt/DuckStation/duckstation.AppImage
sudo chmod +x /opt/DuckStation/duckstation.AppImage

# 3. Create symlink in /usr/local/bin
sudo ln -sf /opt/DuckStation/duckstation.AppImage /usr/local/bin/duckstation

# 4. Download icon if not present
ICON_DIR="$HOME/.local/share/icons"
ICON_PATH="$ICON_DIR/duckstation.png"
if [[ ! -f "$ICON_PATH" ]]; then
    mkdir -p "$ICON_DIR"
    curl -L https://www.duckstation.org/assets/img/ducko256.png -o "$ICON_PATH"
fi

# 5. Create desktop entry
DESKTOP_FILE="$HOME/.local/share/applications/duckstation.desktop"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=DuckStation
Comment=PlayStation 1 Emulator
Exec=/opt/DuckStation/duckstation.AppImage
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Game;Emulator;
EOF

echo "DuckStation AppImage installed!"
echo "You can now run 'duckstation' from the terminal or find it in your application menu."
