-- 1. Tecla lider
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 2. Interfaz basica
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.statuscolumn = "%s %{v:lnum} %{v:relnum}"
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

-- Exit terminal
vim.keymap.set('t', '<leader>ff', [[<C-\><C-n>]], { desc = 'Exit terminal mode with space + f + f', nowait = true })
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt_local.number = false         -- Hide absolute line numbers
        vim.opt_local.relativenumber = false -- Hide relative line numbers
        vim.opt_local.statuscolumn = ""      -- Clear your custom
        vim.opt_local.signcolumn = "no"      -- Hide sign column
        vim.opt_local.spell = false          -- Disable spellcheck in the
    end,
})

-- 3. Indentacion
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 4. Busqueda inteligente
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 5. Sincronizar clipboards
vim.opt.clipboard = 'unnamedplus'

-- 9. Fast escape insert mode
vim.keymap.set("i", "jj", "<Esc>", {
    desc = "Salir de insert mode",
    noremap = true,
    nowait = true
})

-- Vim diagnostic
vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    float = { source = 'if_many' },
    jump = { float = true },
})

-- Mostrar diagnostico
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'mostrar diagnosticos' })

-- Moverse entre pestañas
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left windows' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right windows' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower windows' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper windows' })

-- Pestañas vacias vertical y horizontal
vim.keymap.set('n', '<leader>sn', '<cmd>vnew<cr>', { desc = 'Split vertical vacío' })
vim.keymap.set('n', '<leader>vn', '<cmd>new<cr>', { desc = 'Split horizontal vacío' })

-- Cerrar buffer sin cerrar la ventana
vim.keymap.set('n', '<leader>mm', function()
    local cur = vim.api.nvim_get_current_buf()
    vim.cmd('bprevious')
    if vim.api.nvim_get_current_buf() == cur then
        vim.cmd('enew')
    end
    vim.cmd('bdelete! ' .. cur)
end, { desc = 'Close buffer (preserve window layout)' })

-- Destacar yanks
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function() vim.highlight.on_yank() end
})

-- Packages añadidos
vim.pack.add({
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/karb94/neoscroll.nvim',
    'https://github.com/scottmckendry/cyberdream.nvim',
    { src = 'https://github.com/saghen/blink.cmp',     version = vim.version.range('1.x'), build = 'cargo build --release' },
    'https://github.com/esmuellert/codediff.nvim',
    'https://github.com/kdheepak/lazygit.nvim',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/olrtg/emmet-language-server',
    'https://github.com/rafamadriz/friendly-snippets',
    { src = 'https://github.com/nvim-mini/mini.pairs', version = 'stable' },
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    { src = 'https://github.com/iamcco/markdown-preview.nvim', build = 'cd app && ./install.sh' },
    'https://github.com/lervag/vimtex',
})


-- FzfLua

require("fzf-lua").setup({
    keymap = {
        builtin = {
            ["<C-d>"] = 'preview-page-down',
            ["<C-u>"] = 'preview-page-up',
        }
    }
})


vim.keymap.set('n', '<leader><leader>', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Find live grep' })
vim.keymap.set('n', '<leader>b', '<cmd>FzfLua buffers<cr>', { desc = 'Fuzzy find buffers' })
-- fuzzy find current buffer directory
vim.keymap.set('n', '<leader>fb', function()
    require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') })
end, { desc = 'Find files in current buffer directory' })

-- fuzzy find from home
vim.keymap.set('n', '<leader>fh', function()
    require('fzf-lua').files({ cwd = vim.fn.expand('~') })
end, { desc = 'Find files in home (~)' })


-- Tree-sitter
-- Usando el comando :TSInstall "nombre-del-parser"
vim.cmd('syntax off')
vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

-- LSP
vim.lsp.enable({
    'ty',
    'ruff',
    'lua_ls',
    'ts_ls',
    'tailwindcss',
    'clangd',
    'marksman',
    'texlab',
})

-- NATIVE 0.12 CLIENT ATTACHMENT FOR EMMET
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'html', 'css', 'typescriptreact', 'javascriptreact' },
    callback = function(args)
        vim.lsp.start({
            name = 'emmet_ls',
            cmd = { 'emmet-language-server', '--stdio' }, -- Calls your global pnpm binary
            root_dir = vim.fs.root(args.buf, { 'package.json', '.git' }) or vim.fn.expand('%:p:h'),
        })
    end,
})



vim.o.signcolumn = 'yes'
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })


-- Auto-format ("lint") on save (adapted from neovim docs :help auto-format)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp.fmt', { clear = false }),
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

--NeoScroll
require('neoscroll').setup({
    hide_cursor = false,
    stop_eof = true,
    easing = 'quadratic',
    duration_multiplier = 0.30,
})

-- Blink.cmp
require('blink.cmp').setup({
    snippets = {
        preset = 'default',
    },
    signature = {
        enabled = true,
        window = { show_documentation = false },
    },
    completion = {
        keyword = {
            -- Ensures that brief keywords like 'div' match against broader structural elements
            range = 'full',
        },
        list = {
            -- Forces blink to pull the complete structural expansion snippet text out of the backend
            selection = { preselect = true, auto_insert = false }
        }
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            snippets = {
                opts = {
                    search_paths = {
                        vim.fn.stdpath('config') .. '/Latex-WSL/snippets',
                    },
                },
            },
        },
    },
    keymap = {
        preset = 'default',
    },
})

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Mostrar documentacion" })

-- LazyGit
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Lazygit (launched CWD)' })
vim.keymap.set('n', '<leader>gf', function()
    local dir
    if vim.bo.filetype == 'oil' then
        dir = require('oil').get_current_dir()
    elseif vim.bo.buftype == 'terminal' then
        dir = vim.fn.getcwd()
    else
        dir = vim.fn.expand('%:p:h')
    end

    if dir and dir ~= '' then
        require('lazygit').lazygit(dir)
    else
        require('lazygit').lazygit()
    end
end, { desc = 'Lazygit (current file or oil directory)' })

-- Codediff
require("codediff").setup({})

-- Tema
require("cyberdream").setup({
    transparent = true,
    variant = "default",
    saturation = 1,
})

vim.cmd("colorscheme cyberdream")

-- Oil
require("oil").setup({
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<leader>o"] = { "actions.toggle_hidden", desc = "Toggle hidden files" },
        ["<leader>p"] = { "actions.refresh", desc = "Refresh directory" },
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- mini pairs
-- adds auto creation of parenthesys and space on enter
require('mini.pairs').setup({})

-- for markdown inside neovim
require('render-markdown').setup({})

-- VimTeX (Wayland / WSLg native - See ./Latex-WSL for details)
vim.g.vimtex_view_method = 'zathura_simple'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_view_zathura_options = ''
vim.g.vimtex_view_automatic = 0
vim.g.vimtex_compiler_latexmk = {
    aux_dir = 'build',
    out_dir = 'pdfs',
}
