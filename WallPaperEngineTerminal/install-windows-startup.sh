#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AHK_SOURCE="${SCRIPT_DIR}/TerminalWallpaper.ahk"

echo "=== Windows Startup Installer for TerminalWallpaper.ahk ==="
echo ""

# 1. Check if source AHK file exists
if [ ! -f "$AHK_SOURCE" ]; then
    echo "❌ Error: Source file '$AHK_SOURCE' not found."
    exit 1
fi

# 2. Check if AutoHotkey is installed on Windows
AHK_INSTALLED=false

# Check common install paths
if [ -d "/mnt/c/Program Files/AutoHotkey/v2" ] || \
   [ -f "/mnt/c/Program Files/AutoHotkey/AutoHotkey64.exe" ] || \
   [ -f "/mnt/c/Program Files/AutoHotkey/v2/AutoHotkey64.exe" ]; then
    AHK_INSTALLED=true
fi

# Check via Windows command prompt if not found in default paths
if [ "$AHK_INSTALLED" = false ]; then
    if cmd.exe /c "where AutoHotkey.exe" >/dev/null 2>&1 || cmd.exe /c "where AutoHotkey64.exe" >/dev/null 2>&1; then
        AHK_INSTALLED=true
    fi
fi

if [ "$AHK_INSTALLED" = false ]; then
    echo "❌ AutoHotkey v2 was NOT detected on your Windows system."
    echo ""
    echo "AutoHotkey v2 is required to run TerminalWallpaper.ahk."
    echo "You can install it on Windows by running:"
    echo "    winget install AutoHotkey.AutoHotkey"
    echo ""
    echo "Or download the official installer directly from:"
    echo "    https://www.autohotkey.com/"
    echo ""
    echo "Aborting startup installation until AutoHotkey is installed."
    exit 1
else
    echo "✅ AutoHotkey installation detected on Windows."
fi

# 3. Locate the Windows Startup Folder
echo "🔍 Locating Windows Startup directory..."
WIN_STARTUP_RAW=$(cmd.exe /c "echo %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" 2>/dev/null | tr -d '\r')

if [ -z "$WIN_STARTUP_RAW" ]; then
    echo "❌ Failed to query %APPDATA% from Windows environment."
    exit 1
fi

WSL_STARTUP_PATH=$(wslpath "$WIN_STARTUP_RAW")

if [ ! -d "$WSL_STARTUP_PATH" ]; then
    echo "📁 Creating Windows Startup directory at: $WSL_STARTUP_PATH"
    mkdir -p "$WSL_STARTUP_PATH"
fi

# 4. Copy the script to Windows Startup
TARGET_AHK="${WSL_STARTUP_PATH}/TerminalWallpaper.ahk"
echo "📋 Copying TerminalWallpaper.ahk to: $TARGET_AHK"
cp -f "$AHK_SOURCE" "$TARGET_AHK"

echo ""
echo "🎉 SUCCESS!"
echo "TerminalWallpaper.ahk has been installed into your Windows Startup directory."
echo "It will automatically start every time Windows boots."
echo ""
echo "👉 To launch it immediately without rebooting, run:"
echo "   cmd.exe /c \"start \"\" \"${WIN_STARTUP_RAW}\\TerminalWallpaper.ahk\"\""
