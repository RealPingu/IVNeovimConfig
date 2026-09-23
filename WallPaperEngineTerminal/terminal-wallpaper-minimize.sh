#!/usr/bin/env bash
# ==============================================================================
# ⚠️ [UNTESTED / EXPERIMENTAL] Linux Window Auto-Minimize Companion
# ==============================================================================
# Purpose:
#   Equivalent of TerminalWallpaper.ahk for Linux / X11 environments.
#   Monitors active window focus. When a terminal emulator (e.g. Alacritty,
#   Kitty, WezTerm, GNOME Terminal) is focused, it minimizes other normal
#   windows on the current workspace so live wallpapers (e.g. Komorebi,
#   linux-wallpaperengine, feh, mpvpaper) show cleanly behind transparent terminals.
#
# Requirements:
#   - xdotool
#   - wmctrl
#   - xprop (from x11-utils)
# ==============================================================================

set -euo pipefail

# List of terminal process/class names to match (case-insensitive grep pattern)
TERMINAL_PATTERN="alacritty|kitty|wezterm|gnome-terminal|foot|st|xterm|urxvt|tilix|terminator"

echo "=== [UNTESTED] Linux Terminal Wallpaper Minimize Daemon ==="
echo "Monitoring window focus for terminals matching: ${TERMINAL_PATTERN}"
echo "Press Ctrl+C to stop."
echo ""

# Dependency check
for cmd in xdotool wmctrl xprop; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "❌ Error: Required tool '$cmd' is not installed."
        echo "Install it via your package manager: sudo apt install xdotool wmctrl x11-utils"
        exit 1
    fi
done

last_active=""

clean_workspace() {
    local term_wid="$1"
    
    # Get current active desktop / workspace index
    local current_desktop
    current_desktop=$(xdotool get_desktop)
    
    # List all managed windows on the current desktop
    wmctrl -l | while read -r line; do
        local wid
        wid=$(echo "$line" | awk '{print $1}')
        local desktop
        desktop=$(echo "$line" | awk '{print $2}')
        
        # Convert hex window ID to decimal for comparison with xdotool
        local dec_wid=$((wid))
        local dec_term=$((term_wid))
        
        # Skip the active terminal itself
        if [ "$dec_wid" -eq "$dec_term" ]; then
            continue
        fi
        
        # Only minimize windows on the current active workspace (skip sticky windows -1)
        if [ "$desktop" = "$current_desktop" ]; then
            # Verify window is a normal client window (not desktop, dock, or panel)
            local win_type
            win_type=$(xprop -id "$wid" _NET_WM_WINDOW_TYPE 2>/dev/null || true)
            if [[ "$win_type" =~ _NET_WM_WINDOW_TYPE_NORMAL ]] || [ -z "$win_type" ]; then
                # Minimize window
                xdotool windowminimize "$wid" 2>/dev/null || true
            fi
        fi
    done
}

# Monitor active window changes in X11
xprop -root -spy _NET_ACTIVE_WINDOW | while read -r line; do
    active_wid=$(echo "$line" | awk '{print $NF}')
    
    # Skip invalid / empty window IDs
    if [ "$active_wid" = "0x0" ] || [ -z "$active_wid" ] || [ "$active_wid" = "$last_active" ]; then
        continue
    fi
    
    last_active="$active_wid"
    
    # Query window class / process name
    win_class=$(xprop -id "$active_wid" WM_CLASS 2>/dev/null || true)
    
    if echo "$win_class" | grep -E -i -q "$TERMINAL_PATTERN"; then
        clean_workspace "$active_wid"
    fi
done
