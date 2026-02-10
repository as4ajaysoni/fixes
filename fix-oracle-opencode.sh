#!/bin/bash

export COLORTERM=truecolor
echo "Fixing OpenCode theme error..."

# Backup existing config
CONFIG_FILE="$HOME/.config/opencode/opencode.jsonc"
BACKUP_FILE="$HOME/.config/opencode/opencode.jsonc.backup-$(date +%Y%m%d-%H%M%S)"

if [ -f "$CONFIG_FILE" ]; then
    echo "Backing up config to $BACKUP_FILE"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
    
    # Remove theme configuration temporarily
    sed -i.tmp '/^[[:space:]]*"theme":/d' "$CONFIG_FILE"
    rm -f "$CONFIG_FILE.tmp"
    echo "Removed theme configuration from config"
fi

# Clear cache
echo "Clearing OpenCode cache..."
rm -rf ~/.cache/opencode
rm -rf ~/.local/share/opencode

# Ensure truecolor support
if ! grep -q "COLORTERM=truecolor" ~/.bashrc && ! grep -q "COLORTERM=truecolor" ~/.zshrc; then
    echo "Adding truecolor support..."
    echo 'export COLORTERM=truecolor' >> ~/.bashrc
    export COLORTERM=truecolor
fi

echo "Done! Starting OpenCode with default theme..."
opencode
