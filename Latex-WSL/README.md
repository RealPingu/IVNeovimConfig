# 📄 LaTeX & VimTeX Setup Guide (WSL2 / WSLg)

A complete, battle-tested guide to setting up **VimTeX**, **Zathura (PDF viewer)**, **latexmk**, and **SyncTeX** with Neovim in **WSL2 / WSLg**.

---

## 📦 Step 1: Install System Dependencies

Run the following command in your Ubuntu / WSL2 terminal:

```bash
sudo apt update && sudo apt install -y \
  latexmk \
  texlive-latex-base \
  texlive-latex-extra \
  texlive-fonts-recommended \
  zathura \
  zathura-pdf-poppler \
  adwaita-icon-theme \
  texlab \
  chktex
```

---

## 🖱️ Step 2: Fix the WSLg Invisible Mouse Cursor

In WSLg, Wayland GTK applications (like Zathura) require local user-level cursor theme paths to properly render the mouse pointer.

Run the provided helper script to automatically configure your cursor and Zathura:

```bash
cd ~/.config/nvim/Latex-WSL
./setup-cursor.sh
```

*(This sets up `~/.icons/default/cursors` linking to Adwaita and copies `zathurarc` to `~/.config/zathura/zathurarc`).*

> **Note**: If the mouse cursor does not appear immediately after launching Zathura for the first time, run `wsl --shutdown` from Windows PowerShell / Terminal, then restart Ubuntu to clear WSLg's compositor cache.

---

## ⚙️ Step 3: Enable VimTeX in Neovim

Add the following snippets to your [`~/.config/nvim/init.lua`](../init.lua):

### 1. In `vim.pack.add({ ... })`:
```lua
    -- ... other plugins ...
    'https://github.com/lervag/vimtex',
```

### 2. In `vim.lsp.enable({ ... })`:
```lua
    -- ... other LSPs ...
    'texlab',
```

### 3. At the bottom of `init.lua`:
```lua
-- VimTeX (Wayland / WSLg native)
vim.g.vimtex_view_method = 'zathura_simple'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_view_zathura_options = '--mode fullscreen'
```

### 4. Install Tree-sitter Syntax Highlighting Parser:
Inside Neovim, run:
```vim
:TSInstall latex
```

---

## ⌨️ Keybindings & Usage Cheat Sheet

### VimTeX in Neovim
| Keybinding | Action |
| :--- | :--- |
| **`<Space>ll`** | **Toggle Continuous Compilation** (starts `latexmk` background compiler & opens Zathura; press again to stop) |
| **`<Space>lv`** | **Forward Search** (jump from cursor in Neovim straight to that location in Zathura PDF) |
| **`<Space>lt`** | **Table of Contents** (open an interactive document outline drawer inside Neovim) |
| **`<Space>le`** | **Error Log** (opens Quickfix list showing LaTeX compiler errors and warnings) |
| **`<Space>lc`** | **Clean auxiliary files** (removes `.aux`, `.log`, `.fls`, `.out`) |
| **`dse`** | **Delete surrounding environment** (e.g. `\begin{equation} ... \end{equation}` ➔ `...`) |
| **`cse`** | **Change surrounding environment** (e.g. change `itemize` to `enumerate`) |
| **`tse`** | **Toggle star** (e.g. toggle `\begin{equation}` ➔ `\begin{equation*}`) |

---

## 🧩 Custom Callout Box Snippets

Preconfigured in [`Latex-WSL/snippets/tex.json`](./snippets/tex.json) for `tcolorbox` notes:

| Trigger Prefix | Expanded LaTeX Block | Description |
| :--- | :--- | :--- |
| **`defbox`** or `definitionbox` | `\begin{definitionbox}{Title} ... \end{definitionbox}` | Blue callout box for definitions & key concepts |
| **`warnbox`** or `warningbox` | `\begin{warningbox}{Title} ... \end{warningbox}` | Orange/Red callout box for warnings & critical notes |
| **`exbox`** or `examplebox` | `\begin{examplebox}{Title} ... \end{examplebox}` | Green callout box for examples & tips |

---

### Zathura PDF Viewer Navigation
| Key | Action |
| :--- | :--- |
| **`Ctrl + Left Click`** | **SyncTeX Inverse Search** (jumps directly from the PDF back to that line in Neovim!) |
| **`j` / `k`** | Scroll down / up smoothly |
| **`d` / `u`** | Half-page down / up |
| **`Space`** / **`Shift + Space`** | Full-page down / up |
| **`gg`** / **`G`** | Jump to first / last page |
| **`<Tab>`** | Toggle Table of Contents / Index drawer |
| **`+` / `-`** | Zoom in / Zoom out |
| **`a` / `s`** | Fit-to-best / Fit-to-width |
| **`F11`** | Toggle Fullscreen mode |
| **`r`** | Rotate page 90° clockwise |
| **`Ctrl + r`** | Invert colors (Dark mode) |
| **`:`** | Open Zathura command line (`:open <file>`, `:bmark <name>`, `:q`) |
