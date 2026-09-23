# 🖼️ Wallpaper Engine & Terminal Transparency Companion

This utility is designed for setups using **Wallpaper Engine** and a **transparent terminal** (such as Windows Terminal running Ubuntu/WSL2).

---

## 🎯 The Purpose

When your terminal and Neovim are configured with a transparent background, opening the terminal over other open windows (browsers, Discord, file managers) makes text hard to read and obstructs your animated wallpaper.

This tool automatically detects when **Windows Terminal** is focused and instantly minimizes all other windows on that monitor—letting your live Wallpaper Engine background shine through cleanly.

---

## ⚙️ Step 1: Windows Terminal Transparency Setup

To enable transparency for your Ubuntu/WSL2 environment:

1. Open **Windows Terminal**.
2. Open Settings by pressing `Ctrl + ,` (or click the dropdown arrow `⌵` in the titlebar and select **Settings**).
3. In the left sidebar under **Profiles**, click on **Ubuntu** (or your default profile).
4. Select the **Appearance** tab.
5. Scroll down to the **Transparency** section:
   - Set **Background opacity** to between **`70%`** and **`85%`** (adjust to your preference).
7. *(Note: Neovim's `cyberdream.nvim` theme in this repository already has `transparent = true` configured).*

---

## 🪟 Windows Setup (AutoHotkey v2)

### 1. Prerequisites: Install AutoHotkey v2
The script requires **AutoHotkey v2.0+** installed on your Windows host.

Install it via Windows Terminal (PowerShell / CMD):
```powershell
winget install AutoHotkey.AutoHotkey
```
*Or download the official installer directly from [autohotkey.com](https://www.autohotkey.com/).*

---

### 2. Auto-Install to Windows Startup (Recommended)

Run the provided helper script from WSL:

```bash
cd ~/.config/nvim/wpe-minimize-win
./install-windows-startup.sh
```

**What the installer does:**
1. Verifies that AutoHotkey v2 is installed on Windows.
2. Resolves your Windows Startup folder (`%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`).
3. Copies `TerminalWallpaper.ahk` into the Startup directory so it launches automatically whenever Windows starts.

---

## 🧠 How `TerminalWallpaper.ahk` Works

The script runs quietly in the background and includes safety checks to ensure a smooth desktop experience:

* **Trigger**: Only activates when `WindowsTerminal.exe` gains active focus.
* **Alt-Tab Safety**: Detects if the `Alt` key is held down and pauses execution so Alt-Tabbing through apps is never interrupted.
* **Taskbar & Tray Safety**: Detects mouse position and ignores clicks on the Windows Taskbar, notification area, or system flyouts.
* **Tool Window Filtering**: Skips popups, context menus, tooltips (`WS_EX_TOOLWINDOW`), and Windows Explorer shell elements.
* **Multi-Monitor Awareness**: Uses the Win32 `MonitorFromWindow` API to **only minimize windows located on the exact same monitor as the focused terminal**, leaving secondary monitors completely untouched.

---

## 🐧 Linux / X11 Equivalent (Experimental)

> [!WARNING]
> **Status: `[UNTESTED / EXPERIMENTAL]`**
> The Linux script is provided as an experimental counterpart for native Linux / X11 desktop environments (e.g. i3, bspwm, XFCE, GNOME on X11).

### Prerequisites:
```bash
sudo apt install -y xdotool wmctrl x11-utils
```

### Usage:
```bash
cd ~/.config/nvim/wpe-minimize-win
./terminal-wallpaper-minimize.sh &
```

**How it works:**
- Monitors `_NET_ACTIVE_WINDOW` events via `xprop`.
- Checks if the focused window matches common terminal classes (`alacritty`, `kitty`, `wezterm`, `gnome-terminal`, `foot`, `st`).
- Minimizes all other normal client windows on the current active workspace.

**TODO**
- Test script with native Linux distros.
- Test different Linux terminals that allows transparency.
