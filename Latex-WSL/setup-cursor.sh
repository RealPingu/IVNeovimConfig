#!/usr/bin/env bash
# ==============================================================================
# Helper Script: Fix Invisible Mouse Cursor in WSLg & Configure Zathura
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Setting up WSLg Cursor & Zathura Config ==="
echo ""

# 1. Create ~/.icons/default cursor symlinks
echo "📦 Setting up user cursor theme in ~/.icons/default..."
mkdir -p ~/.icons/default

if [ -d "/usr/share/icons/Adwaita/cursors" ]; then
    ln -sfn /usr/share/icons/Adwaita/cursors ~/.icons/default/cursors
    ln -sfn /usr/share/icons/Adwaita ~/.icons/Adwaita
    echo "✅ Linked /usr/share/icons/Adwaita/cursors to ~/.icons/default/cursors"
else
    echo "⚠️ Warning: /usr/share/icons/Adwaita/cursors not found. Installing adwaita-icon-theme..."
    sudo apt install -y adwaita-icon-theme
    ln -sfn /usr/share/icons/Adwaita/cursors ~/.icons/default/cursors
    ln -sfn /usr/share/icons/Adwaita ~/.icons/Adwaita
fi

cat << 'EOF' > ~/.icons/default/index.theme
[Icon Theme]
Name=Default
Comment=Default Cursor Theme
Inherits=Adwaita
EOF

echo "✅ Created ~/.icons/default/index.theme"

# 2. Configure GTK3 settings
echo "📦 Setting up ~/.config/gtk-3.0/settings.ini..."
mkdir -p ~/.config/gtk-3.0
cat << 'EOF' > ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-cursor-theme-name = Adwaita
gtk-cursor-theme-size = 24
EOF
echo "✅ Created ~/.config/gtk-3.0/settings.ini"

# 3. Copy zathurarc configuration
echo "📦 Setting up ~/.config/zathura/zathurarc..."
mkdir -p ~/.config/zathura
cp -f "${SCRIPT_DIR}/zathurarc" ~/.config/zathura/zathurarc
echo "✅ Installed ~/.config/zathura/zathurarc"

echo ""
echo "🎉 Done! Cursor fix and Zathura configuration are ready."
echo "If cursor does not appear immediately, run 'wsl --shutdown' in PowerShell and restart Ubuntu."
