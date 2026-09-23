-- ==============================================================================
-- LaTeX & VimTeX Configuration for Neovim (WSL2 / WSLg)
-- ==============================================================================
-- To enable this configuration in your main ~/.config/nvim/init.lua:
--
-- 1. In vim.pack.add({ ... }), add:
--    'https://github.com/lervag/vimtex',
--
-- 2. In vim.lsp.enable({ ... }), add:
--    'texlab',
--
-- 3. Paste the following configuration block at the bottom of your init.lua:
-- ==============================================================================

-- VimTeX (Wayland / WSLg native)
vim.g.vimtex_view_method = 'zathura_simple'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_view_zathura_options = '--mode fullscreen'
