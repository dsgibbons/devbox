#!/bin/bash
set -e

# Install devbox to ~/.local/bin
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
DEVBOX_URL="https://raw.githubusercontent.com/dsgibbons/devbox/main/devbox"

mkdir -p "$INSTALL_DIR"
curl -fsSL "$DEVBOX_URL" -o "$INSTALL_DIR/devbox"
chmod +x "$INSTALL_DIR/devbox"

echo "Installed devbox to $INSTALL_DIR/devbox"

# Check if INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "Add to your PATH:"
    echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
fi
