-- 1. Tecla lider
vim.g.mapleader = ' '
vim.g.localleader = ' '

-- 2. Interfaz basica
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.statuscolumn = "%s %{v:lnum} %{v:relnum}"
-- Exit terminal
vim.keymap.set('t', '<leader>ff', [[<C-\><C-n>]], { desc = 'Exit terminal mode with jj', nowait = true })

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
    { src = 'https://github.com/saghen/blink.cmp',     version = vim.version.range('1.x'), build = 'cargo build --realese' },
    'https://github.com/esmuellert/codediff.nvim',
    'https://github.com/kdheepak/lazygit.nvim',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/jonroosevelt/gemini-cli.nvim',
    'https://github.com/olrtg/emmet-language-server',
    'https://github.com/rafamadriz/friendly-snippets',
    { src = 'https://github.com/nvim-mini/mini.pairs', version = 'stable' },
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
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
        default = { 'lsp', 'path', 'snippets', 'buffer' }
    },
    keymap = {
        preset = 'default',
    },
})

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Mostrar documentacion" })

-- LazyGit
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Lazygit' })

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
    }
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- mini pairs
-- adds auto creation of parenthesys and space on enter
require('mini.pairs').setup({})

-- for markdown inside neovim
-- note that it requires a "nerd font" in the terminal to work properly
-- and either 'https://github.com/nvim-mini/mini.icons' or 'https://github.com/nvim-tree/nvim-web-devicons'.
-- for icons
require('render-markdown').setup({})
