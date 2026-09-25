# IVNeovimConfig 🚀

A lightweight, modern, and high-performance Neovim configuration built for **Neovim 0.12+** and tailored for **WSL2 (Ubuntu/Debian)**.

It uses native Neovim features (native `vim.pack.add` package management, native `vim.lsp.enable`, and built-in Treesitter) for lightning-fast startup with zero third-party plugin manager overhead.

---

## ✨ Features

- **Package Management**: Native `vim.pack.add` with reproducible lockfile (`nvim-pack-lock.json`).
- **Aesthetic**: [cyberdream.nvim](https://github.com/scottmckendry/cyberdream.nvim) theme with transparent background support.
- **Completion**: [blink.cmp](https://github.com/saghen/blink.cmp) + [friendly-snippets](https://github.com/rafamadriz/friendly-snippets).
- **Fuzzy Finder**: [fzf-lua](https://github.com/ibhagwan/fzf-lua) for high-performance file searching and live project grepping.
- **File Explorer**: [oil.nvim](https://github.com/stevearc/oil.nvim) for editing filesystem buffers like text.
- **LSP & Formatting**: Native `vim.lsp` with auto-format on save and dynamic [Emmet](https://github.com/olrtg/emmet-language-server) attachment for HTML/JSX/CSS.
- **Git**: [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) (with smart CWD & Oil buffer repository resolution) and [codediff.nvim](https://github.com/esmuellert/codediff.nvim).
- **WSL2 Clipboard**: Synchronized shared clipboard between Windows and WSL2 via `xclip`.

---

## 📋 Requirements & Prerequisites

### 1. Neovim `v0.12.0` or newer
This configuration requires Neovim 0.12+ for native packaging and modern LSP/Treesitter features.

```bash
# Download and install Neovim v0.12+ (AppImage)
mkdir -p ~/.local/bin
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage ~/.local/bin/nvim

# Ensure ~/.local/bin is in your PATH (e.g. in ~/.bashrc)
export PATH="$HOME/.local/bin:$PATH"
```

---

### 2. System CLI Tools & WSL2 Clipboard

Install the core system packages needed for searching, git, compiling Treesitter parsers, clipboard bridging, and browser integration in WSL2:

```bash
# Ubuntu / Debian / WSL2
sudo apt update
sudo apt install -y \
  xclip \
  ripgrep \
  fd-find \
  fzf \
  gcc \
  tar \
  curl \
  git \
  lazygit \
  wslu
```

> **WSL2 Integration Notes**:
> - **Clipboard (`xclip`)**: Enables Neovim's `vim.opt.clipboard = 'unnamedplus'` to communicate across the WSL2 boundary with the Windows host clipboard (`Ctrl+C` / `Ctrl+V`).
> - **Browser Previews (`wslu` / `wslview`)**: Allows plugins like `markdown-preview.nvim` to open HTML previews directly in your default Windows web browser.

---

### 3. Language Servers & External Linters

The configuration connects to external Language Servers and formatters. Install the ones you need for your workflow:

#### Web / Frontend (via `pnpm` or `npm`)
```bash
# Emmet, TypeScript, Tailwind CSS
pnpm add -g @olrtg/emmet-language-server typescript typescript-language-server @tailwindcss/language-server
```

#### Python
```bash
# Ruff (Extremely fast linter and formatter)
pip install --user ruff
# or via cargo: cargo install ruff
```

#### Lua
```bash
# Lua Language Server
sudo apt install -y lua-language-server
```

#### C / C++
```bash
# Clangd
sudo apt install -y clangd
```

#### Markdown
```bash
# Marksman Language Server
sudo apt install -y marksman
# or download binary from https://github.com/artempyanykh/marksman/releases
```

---

### 4. Font Recommendation
Install a [Nerd Font](https://www.nerdfonts.com/) (e.g., **JetBrains Mono Nerd Font**) on your Windows host and configure it as your font in **Windows Terminal** to render file icons and markdown glyphs properly.

---

## 🚀 Quickstart Installation

1. **Clone this repository** into your Neovim configuration directory:
   ```bash
   git clone https://github.com/RealPingu/IVNeovimConfig.git ~/.config/nvim
   ```

2. **Open Neovim**:
   ```bash
   nvim
   ```
   *Neovim will automatically download and install all 15 plugins on first startup via `vim.pack.add`.*

3. **Install Core Treesitter Parsers**:
   Inside Neovim, run:
   ```vim
   :TSInstall bash c cpp css html javascript json lua markdown markdown_inline python regex rust toml tsx typescript yaml
   ```

---

## ⌨️ Keybindings Cheat Sheet

### General & Navigation
| Keybinding | Mode | Action |
| :--- | :---: | :--- |
| `<Space>` | Normal | **Leader key** |
| `jj` | Insert | Fast escape to Normal mode |
| `<leader>ff` | Terminal | Exit terminal mode (`<C-\><C-n>`) |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Normal | Move focus between split windows |
| `<leader>sn` | Normal | Open empty vertical split (`:vnew`) |
| `<leader>vn` | Normal | Open empty horizontal split (`:new`) |
| `<leader>mm` | Normal | Close current buffer while preserving window split layout |
| `-` | Normal | Open [Oil.nvim](https://github.com/stevearc/oil.nvim) parent directory file browser |
| `<leader>o` | Oil Buffer | Toggle hidden files in Oil |
| `<leader>p` | Oil Buffer | Refresh directory listing in Oil |

### Fuzzy Search ([fzf-lua](https://github.com/ibhagwan/fzf-lua))
| Keybinding | Mode | Action |
| :--- | :---: | :--- |
| `<leader><leader>` | Normal | Find files in project |
| `<leader>/` | Normal | Live grep text in project (powered by `ripgrep`) |
| `<leader>b` | Normal | Find open buffers |
| `<leader>fb` | Normal | Find files in current buffer directory |
| `<leader>fh` | Normal | Find files in home (`~`) directory |

### LSP & Code Intelligence
| Keybinding | Mode | Action |
| :--- | :---: | :--- |
| `gd` | Normal | Go to definition |
| `K` | Normal | Hover documentation / signatures |
| `<leader>d` | Normal | Open floating diagnostic window |
| *Auto* | On Save | Auto-formats code with attached LSP server |

### Git & Tools
| Keybinding | Mode | Action |
| :--- | :---: | :--- |
| `<leader>gg` | Normal | Launch **LazyGit** from Neovim launched directory (CWD) |
| `<leader>gf` | Normal | Launch **LazyGit** scoped to current file or **Oil** directory's Git repo |

---

## 📦 Plugin Ecosystem & External Dependencies

| Plugin | Purpose | External Tool Requirements |
| :--- | :--- | :--- |
| [`ibhagwan/fzf-lua`](https://github.com/ibhagwan/fzf-lua) | Fuzzy Finder & Grep | `fzf`, `ripgrep` (`rg`), `fd-find` (`fd`) |
| [`nvim-treesitter/nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax Highlighting & AST | `gcc`/`clang`, `tree-sitter-cli`, `tar`, `curl` |
| [`neovim/nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) | Language Server Client | Language servers (`ruff`, `lua-language-server`, `ts_ls`, `clangd`, etc.) |
| [`karb94/neoscroll.nvim`](https://github.com/karb94/neoscroll.nvim) | Smooth Window Scrolling | Pure Lua (no external dependencies) |
| [`scottmckendry/cyberdream.nvim`](https://github.com/scottmckendry/cyberdream.nvim) | Colorscheme | TrueColor terminal support |
| [`saghen/blink.cmp`](https://github.com/saghen/blink.cmp) | Autocompletion & Snippets | Prebuilt binary auto-fetched (or `cargo` / Rust) |
| [`esmuellert/codediff.nvim`](https://github.com/esmuellert/codediff.nvim) | Side-by-side Code Diffing | Prebuilt binary auto-fetched + system `libgomp.so.1` |
| [`kdheepak/lazygit.nvim`](https://github.com/kdheepak/lazygit.nvim) | Git TUI Floating Window | `lazygit` CLI |
| [`stevearc/oil.nvim`](https://github.com/stevearc/oil.nvim) | File System Editor | `nvim-web-devicons` (optional: `trash-cli`) |
| [`olrtg/emmet-language-server`](https://github.com/olrtg/emmet-language-server) | HTML/JSX/CSS Abbreviations | `@olrtg/emmet-language-server` via `pnpm`/`npm` |
| [`rafamadriz/friendly-snippets`](https://github.com/rafamadriz/friendly-snippets) | Predefined Code Snippets | Pure JSON (no external dependencies) |
| [`nvim-mini/mini.pairs`](https://github.com/nvim-mini/mini.pairs) | Autoclose Brackets & Quotes | Pure Lua (no external dependencies) |
| [`MeanderingProgrammer/render-markdown.nvim`](https://github.com/MeanderingProgrammer/render-markdown.nvim) | In-buffer Markdown Rendering | Treesitter `markdown` & `markdown_inline` parsers + Nerd Font |
| [`nvim-tree/nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons) | File Type Icons | Nerd Font in terminal |
| [`iamcco/markdown-preview.nvim`](https://github.com/iamcco/markdown-preview.nvim) | Browser Markdown Preview | Node.js + `cd app && ./install.sh` + `wslu` (`wslview`) |

---

## 🎨 Wallpaper Engine Transparency Companion

If you use **Wallpaper Engine** and want your live animated wallpaper to display cleanly behind your transparent terminal without other open windows getting in the way, check out the companion tool in [`WallPaperEngineTerminal/`](./WallPaperEngineTerminal):
- **Windows (AutoHotkey v2)**: Automatically minimizes background windows on the same monitor whenever Windows Terminal is focused.
- **Linux (Experimental)**: Equivalent background script for Linux/X11 window managers.

---

## 📄 LaTeX & VimTeX in WSL2

If you write LaTeX and want continuous compilation (`latexmk`), full SyncTeX Forward & Inverse search (`Ctrl + Click`), and PDF viewing via **Zathura** in WSL2/WSLg, check out the dedicated setup guide and automated cursor scripts in [`Latex-WSL/`](./Latex-WSL).


