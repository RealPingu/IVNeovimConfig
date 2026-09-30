local alpha = require('alpha')
local theta = require('alpha.themes.theta')
local dashboard = require('alpha.themes.dashboard')
local utils = require('alpha.utils')

-- Cyberdream Theme Color Highlights for Alpha
vim.api.nvim_set_hl(0, "AlphaDots", { fg = "#7b8496" })                  -- Grey
vim.api.nvim_set_hl(0, "AlphaTitle", { fg = "#bd5eff", bold = true })    -- Cyberdream Purple (#bd5eff)
vim.api.nvim_set_hl(0, "AlphaBorder", { fg = "#7b8496" })                -- Cyberdream Grey (#7b8496)
vim.api.nvim_set_hl(0, "AlphaPenguin", { fg = "#16181a", bold = true })  -- Deep Black (#16181a)
vim.api.nvim_set_hl(0, "AlphaWhite", { fg = "#ffffff", bold = true })    -- Pure White (#ffffff)
vim.api.nvim_set_hl(0, "AlphaEye", { fg = "#ff6e5e", bold = true })      -- Cyberdream Red (#ff6e5e)
vim.api.nvim_set_hl(0, "AlphaBackpack", { fg = "#ff5ea0", bold = true }) -- Cyberdream Pink (#ff5ea0)
vim.api.nvim_set_hl(0, "AlphaCyan", { fg = "#5ef1ff", bold = true })     -- Cyberdream Cyan (#5ef1ff)
vim.api.nvim_set_hl(0, "AlphaKey", { fg = "#5ea1ff", bold = true })      -- Cyberdream Blue (#5ea1ff) for [letter]
vim.api.nvim_set_hl(0, "AlphaBtn", { fg = "#5eff6c" })                   -- Cyberdream Green (#5eff6c) for icons and text
vim.api.nvim_set_hl(0, "AlphaSection", { fg = "#bd5eff", bold = true })  -- Cyberdream Purple (#bd5eff)
vim.api.nvim_set_hl(0, "AlphaDirIcon", { fg = "#5ea1ff" })               -- Folder icon Blue

-- Header ASCII Lines
theta.header.val = {
    [=[                ⡀⣄⣄⣄⣄⣄⡀                                 ]=],
    [=[            ⣀⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄                              ]=],
    [=[         ⡀⣄⣷⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄                            ]=],
    [=[  ⣄⣤⣶⣷⣿⣿⣿⣿⣿⣿⣿⣿⣤⣄⣶⣀⣄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶                           ]=],
    [=[⣄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⣤⣄⣷⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣶                                  󰌽  IVNeovimConfig]=],
    [=[⣀⣄⣄⣄⣄⣤⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⣷⣿⣿⣿⣿⣿⣿⣿⣄                            *────────────────────────────*]=],
    [=[         ⣀⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⣀⣿⣿⣿⣿⣿⣿⣿⣿⣶    ⡀⡀⡀                  ]=],
    [=[           ⡀⣷⣿⣿⣿⣿⣷⣄⣀⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷  ⣀⣷⣷⣤⣤⣷⣀                ]=],
    [=[             ⣶⣶⡀⣀⣤⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⣶⣷⣿⣷⣷⣷⣿⣿⣷⣷⣷⣷⣤⡀             [f]  󰈞  Find File]=],
    [=[             ⣀⡀⠄⡀⣄⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄        ]=],
    [=[             ⣤⠄⠄⠄⠄⠄⡀⣿⣿⣿⣿⣿⣶⣷⣿⣿⣶⣶⣷⣀⣤⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀      ]=],
    [=[            ⡀⣀⠄⠄⠄⠄⠄⠄⣀⣿⣿⣶⣿⣿⣶⣷⣷⣷⣷⣶⣄⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀        [n]  󰝒  New File]=],
    [=[            ⣄⠄⠄⠄⠄⠄⠄⠄⡀⣷⣷⣿⣷⣤⣿⣿⣿⣿⣿⣿⣶⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶     ]=],
    [=[            ⣤⠄⠄⠄⠄⠄⠄⠄⣤⣿⣿⣷⣄⣿⣿⣿⣿⣿⣿⣿⣿⡀⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿     ]=],
    [=[           ⣄⡀⠄⠄⠄⠄⠄⠄⠄⣤⣿⣿⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⣄⣿⣿⣿⣿⣿⣿⣿⣷⣷⣷⣷⣷⣷⣿⣿⣿⡀       [r]  󰄉  Recent Files]=],
    [=[           ⣄⠄⠄⠄⠄⠄⠄⠄⠄⣤⣿⣿⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⣿⣿⣿⣿⣿⣿⣿⣄⣀⣿⣿⣿⣤⣤⣿⣶     ]=],
    [=[           ⡀⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⠄⣤⣿⣿⣿⣿⣿⣿⣿⣶⣿⣀⣷⣿⣿⣿⣿⣿⣿⣿⣤⣶⣶⣷⣿⣿⣿⣶     ]=],
    [=[          ⣀⣀⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣄⣶⣤⣤⣿⣷⡀⣶⣶⣶⣶⣶⣄⣄⣤⣶⣶⣶⣶⣄       [g]  󰊢  Live Grep]=],
    [=[          ⡀⡀⠄⠄⠄⠄⠄⠄⠄⠄⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣄⣤⣤ ⣷⣿⣿⣿⣿⣿⣀⣿⣿⣿⣿⣄⣶    ]=],
    [=[          ⣀⣄⠄⠄⠄⠄⠄⠄⠄⠄⡀⣷⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣷ ⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⣶    ]=],
    [=[          ⡀⣤⠄⠄⠄⠄⠄⠄⠄⠄⠄⡀⣷⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⣿⣿⣤⣶⣷ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷       [o]  󰏇  File Explorer (Oil)]=],
    [=[           ⣶⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⣶⣿⣿⣤⣶⣷ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷    ]=],
    [=[           ⡀⣤⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣤⡀⣷⣿⣿⣿⣿⣷ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶    ]=],
    [=[            ⣤⡀⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣷⡀⣷⣿⣿⣿⣿⣶⣄⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤        [c]  󰒓  Configuration]=],
    [=[             ⣶⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣄⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄       ]=],
    [=[             ⡀⣤⠄⠄⠄⠄⠄⠄⠄⣶⣿⣿⣿⣿⣿⣿⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣀⡀⡀           ]=],
    [=[              ⡀⣤⡀⠄⠄⠄⠄⠄⣀⣿⣿⣿⣿⣿⣷⠄⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀                [q]  󰅚  Quit]=],
    [=[               ⡀⣤⡀⠄⠄⠄⠄⠄⣤⣿⣿⣿⣿⣤⠄⠄⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄             ]=],
    [=[                 ⣄⣄⠄⠄⠄⠄⠄⣀⣷⣿⣶⡀⠄⠄⠄⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄             ]=],
    [=[                  ⣀⣤⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣄⣿⣿⣿⣿⣿⣿⣿⣿⣄             ]=],
    [=[                    ⣄⣄⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣤⣿⣿⣿⣿⣿⣿⣿⣿⣀            ]=],
    [=[                      ⣀⣤⣀⡀⠄⠄⠄⠄⠄⠄⠄⠄⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀           ]=],
    [=[                        ⣀⣿⣿⣶⣀⠄⠄⠄⠄⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄          ]=],
    [=[               ⣀⣤⣤⣶⣶⣤⣶⣷⣷⣿⣿⣿⣷⣤⣤⣄⣶⣶⣷⣿⣿⣄⣤⣷⣿⣿⣿⣿⣿⣿⣿⣤         ]=],
    [=[              ⣄⣶⣶⣷⣿⣿⣿⣿⣷⣿⣷⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣤⣶⣷⣿⣿⣿⣶⣄⣀         ]=],
    [=[             ⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡀⣀⣀⣀       ]=],
}

-- Header Highlights Table
theta.header.opts.hl = {
    { { "AlphaWhite", 16, 37 } },
    { { "AlphaWhite", 12, 54 } },
    { { "AlphaWhite", 9, 66 } },
    { { "AlphaWhite", 2, 44 },  { "AlphaEye", 44, 47 },      { "AlphaWhite", 47, 83 } },
    { { "AlphaWhite", 0, 90 },  { "AlphaTitle", 116, 152 } },
    { { "AlphaWhite", 0, 93 },  { "AlphaBorder", 118, 211 } },
    { { "AlphaWhite", 9, 75 },  { "AlphaBackpack", 79, 88 } },
    { { "AlphaWhite", 11, 71 }, { "AlphaBackpack", 73, 94 } },
    { { "AlphaWhite", 13, 70 }, { "AlphaBackpack", 70, 76 }, { "AlphaWhite", 76, 91 }, { "AlphaBackpack", 91, 112 }, { "AlphaKey", 122, 128 },    { "AlphaBtn", 128, 145 } },
    { { "AlphaWhite", 13, 19 }, { "AlphaPenguin", 19, 22 },  { "AlphaWhite", 22, 70 }, { "AlphaBackpack", 70, 73 },  { "AlphaWhite", 73, 109 },   { "AlphaBackpack", 109, 118 } },
    { { "AlphaWhite", 13, 16 }, { "AlphaPenguin", 16, 31 },  { "AlphaWhite", 31, 70 }, { "AlphaCyan", 70, 73 },      { "AlphaBackpack", 73, 76 }, { "AlphaWhite", 76, 115 },    { "AlphaBackpack", 115, 124 } },
    { { "AlphaWhite", 12, 18 }, { "AlphaPenguin", 18, 36 },  { "AlphaWhite", 36, 54 }, { "AlphaCyan", 54, 75 },      { "AlphaBackpack", 75, 78 }, { "AlphaWhite", 78, 123 },    { "AlphaBackpack", 123, 129 }, { "AlphaKey", 134, 140 },      { "AlphaBtn", 140, 156 } },
    { { "AlphaWhite", 12, 15 }, { "AlphaPenguin", 15, 36 },  { "AlphaWhite", 36, 51 }, { "AlphaCyan", 51, 54 },      { "AlphaWhite", 54, 75 },    { "AlphaCyan", 75, 78 },      { "AlphaBackpack", 78, 81 },   { "AlphaWhite", 81, 126 },     { "AlphaBackpack", 126, 129 } },
    { { "AlphaWhite", 12, 15 }, { "AlphaPenguin", 15, 36 },  { "AlphaWhite", 36, 48 }, { "AlphaCyan", 48, 51 },      { "AlphaWhite", 51, 75 },    { "AlphaCyan", 75, 78 },      { "AlphaBackpack", 78, 84 },   { "AlphaWhite", 84, 126 },     { "AlphaBackpack", 126, 129 } },
    { { "AlphaWhite", 11, 17 }, { "AlphaPenguin", 17, 38 },  { "AlphaWhite", 38, 47 }, { "AlphaCyan", 47, 50 },      { "AlphaWhite", 50, 77 },    { "AlphaCyan", 77, 83 },      { "AlphaBackpack", 83, 86 },   { "AlphaWhite", 86, 128 },     { "AlphaBackpack", 128, 134 }, { "AlphaKey", 138, 144 }, { "AlphaBtn", 144, 164 } },
    { { "AlphaWhite", 11, 14 }, { "AlphaPenguin", 14, 38 },  { "AlphaWhite", 38, 47 }, { "AlphaCyan", 47, 50 },      { "AlphaWhite", 50, 77 },    { "AlphaCyan", 77, 83 },      { "AlphaBackpack", 83, 89 },   { "AlphaWhite", 89, 128 },     { "AlphaBackpack", 128, 131 } },
    { { "AlphaWhite", 11, 14 }, { "AlphaPenguin", 14, 38 },  { "AlphaWhite", 38, 47 }, { "AlphaCyan", 47, 50 },      { "AlphaWhite", 50, 77 },    { "AlphaCyan", 77, 83 },      { "AlphaBackpack", 83, 89 },   { "AlphaWhite", 89, 128 },     { "AlphaBackpack", 128, 131 } },
    { { "AlphaWhite", 10, 16 }, { "AlphaPenguin", 16, 40 },  { "AlphaWhite", 40, 79 }, { "AlphaCyan", 79, 88 },      { "AlphaBackpack", 88, 91 }, { "AlphaWhite", 91, 133 },    { "AlphaBackpack", 133, 136 }, { "AlphaKey", 140, 146 },      { "AlphaBtn", 146, 163 } },
    { { "AlphaWhite", 10, 16 }, { "AlphaPenguin", 16, 40 },  { "AlphaWhite", 40, 85 }, { "AlphaCyan", 85, 91 },      { "AlphaBackpack", 91, 94 }, { "AlphaWhite", 95, 131 },    { "AlphaBackpack", 131, 134 } },
    { { "AlphaWhite", 10, 16 }, { "AlphaPenguin", 16, 43 },  { "AlphaWhite", 43, 85 }, { "AlphaCyan", 85, 91 },      { "AlphaBackpack", 91, 94 }, { "AlphaWhite", 95, 131 },    { "AlphaBackpack", 131, 134 } },
    { { "AlphaWhite", 10, 16 }, { "AlphaPenguin", 16, 43 },  { "AlphaWhite", 43, 76 }, { "AlphaCyan", 76, 91 },      { "AlphaBackpack", 91, 94 }, { "AlphaWhite", 95, 131 },    { "AlphaBackpack", 131, 134 }, { "AlphaKey", 138, 144 },      { "AlphaBtn", 144, 171 } },
    { { "AlphaWhite", 11, 14 }, { "AlphaPenguin", 14, 44 },  { "AlphaWhite", 44, 71 }, { "AlphaCyan", 71, 77 },      { "AlphaWhite", 77, 89 },    { "AlphaBackpack", 89, 92 },  { "AlphaWhite", 93, 129 },     { "AlphaBackpack", 129, 132 } },
    { { "AlphaWhite", 11, 17 }, { "AlphaPenguin", 17, 44 },  { "AlphaWhite", 44, 68 }, { "AlphaCyan", 68, 74 },      { "AlphaWhite", 74, 89 },    { "AlphaBackpack", 89, 92 },  { "AlphaWhite", 93, 126 },     { "AlphaBackpack", 126, 132 } },
    { { "AlphaWhite", 12, 18 }, { "AlphaPenguin", 18, 42 },  { "AlphaWhite", 42, 66 }, { "AlphaCyan", 66, 72 },      { "AlphaWhite", 72, 87 },    { "AlphaBackpack", 87, 102 }, { "AlphaWhite", 102, 120 },    { "AlphaBackpack", 120, 129 }, { "AlphaKey", 134, 140 },      { "AlphaBtn", 140, 161 } },
    { { "AlphaWhite", 13, 16 }, { "AlphaPenguin", 16, 40 },  { "AlphaWhite", 40, 61 }, { "AlphaCyan", 61, 67 },      { "AlphaWhite", 67, 97 },    { "AlphaBackpack", 97, 121 } },
    { { "AlphaWhite", 13, 19 }, { "AlphaPenguin", 19, 40 },  { "AlphaWhite", 40, 61 }, { "AlphaPenguin", 61, 64 },   { "AlphaWhite", 64, 109 } },
    { { "AlphaWhite", 14, 20 }, { "AlphaPenguin", 20, 38 },  { "AlphaWhite", 38, 59 }, { "AlphaPenguin", 59, 62 },   { "AlphaWhite", 62, 101 },   { "AlphaKey", 114, 120 },     { "AlphaBtn", 120, 132 } },
    { { "AlphaWhite", 15, 21 }, { "AlphaPenguin", 21, 39 },  { "AlphaWhite", 39, 57 }, { "AlphaPenguin", 57, 63 },   { "AlphaWhite", 63, 99 } },
    { { "AlphaWhite", 17, 23 }, { "AlphaPenguin", 23, 38 },  { "AlphaWhite", 38, 53 }, { "AlphaPenguin", 53, 62 },   { "AlphaWhite", 62, 95 } },
    { { "AlphaWhite", 18, 24 }, { "AlphaPenguin", 24, 63 },  { "AlphaWhite", 63, 93 } },
    { { "AlphaWhite", 20, 29 }, { "AlphaPenguin", 29, 62 },  { "AlphaWhite", 62, 92 } },
    { { "AlphaWhite", 22, 34 }, { "AlphaPenguin", 34, 58 },  { "AlphaWhite", 58, 91 } },
    { { "AlphaWhite", 24, 39 }, { "AlphaPenguin", 39, 51 },  { "AlphaWhite", 51, 90 } },
    { { "AlphaWhite", 15, 111 } },
    { { "AlphaWhite", 14, 113 } },
    { { "AlphaBtn", 13, 121 } },
}

-- Uniform Horizontal Width & Max Path Settings
local TARGET_WIDTH = 54
local MAX_PATH_LEN = 38

-- Recent Folders Section Generator
local function get_recent_dirs_buttons()
    local oldfiles = vim.v.oldfiles or {}
    local dirs = {}
    local seen = {}
    local home = vim.fn.expand('~')
    for _, file in ipairs(oldfiles) do
        local dir = vim.fn.fnamemodify(file, ":p:h")
        if dir and dir ~= "" and not seen[dir] and vim.fn.isdirectory(dir) == 1 then
            seen[dir] = true
            table.insert(dirs, dir)
            if #dirs >= 4 then break end
        end
    end

    local buttons = {}
    for i, dir in ipairs(dirs) do
        local display_name = dir:gsub('^' .. vim.pesc(home), '~')
        if #display_name > MAX_PATH_LEN then
            display_name = '...' .. display_name:sub(-(MAX_PATH_LEN - 3))
        end
        local shortcut = tostring(i)
        local btn = dashboard.button(shortcut, "  " .. display_name, "<cmd>Oil " .. vim.fn.fnameescape(dir) .. "<cr>")
        btn.opts.width = TARGET_WIDTH
        btn.opts.align_shortcut = "right"
        btn.opts.hl = { { "AlphaDirIcon", 0, 3 }, { "Normal", 3, -1 } }
        btn.opts.hl_shortcut = "AlphaKey"
        table.insert(buttons, btn)
    end
    return buttons
end

local section_recent_dirs = {
    type = "group",
    val = {
        {
            type = "text",
            val = "  Recent Folders",
            opts = {
                hl = "AlphaSection",
                position = "center",
                shrink_margin = false,
            },
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            val = function()
                return get_recent_dirs_buttons()
            end,
            opts = { shrink_margin = false },
        },
    },
}

-- Recent Files Section Generator with Fixed Width and End-Aligned Shortcut Numbers
local function get_recent_files_buttons()
    local oldfiles = utils.get_mru(vim.fn.getcwd(), 6, function(p)
        return string.find(p, "COMMIT_EDITMSG") ~= nil
    end)
    local buttons = {}
    local home = vim.fn.expand('~')
    for i, file in ipairs(oldfiles) do
        local display_name = file:gsub('^' .. vim.pesc(home), '~')
        if #display_name > MAX_PATH_LEN then
            display_name = '...' .. display_name:sub(-(MAX_PATH_LEN - 3))
        end
        local ico, hl = utils.get_icon({ enabled = true, highlight = true, provider = 'mini' }, file)
        ico = ico or ""
        local ico_txt = ico .. "  "
        local shortcut = tostring(i)
        local btn = dashboard.button(shortcut, ico_txt .. display_name, "<cmd>e " .. vim.fn.fnameescape(file) .. "<cr>")
        btn.opts.width = TARGET_WIDTH
        btn.opts.align_shortcut = "right"
        btn.opts.hl_shortcut = "AlphaKey"
        local fb_hl = {}
        if hl then
            table.insert(fb_hl, { hl, 0, #ico })
        end
        local fn_start = display_name:match(".*[/\\]")
        if fn_start ~= nil then
            table.insert(fb_hl, { "Comment", #ico_txt, #ico_txt + #fn_start })
        end
        table.insert(fb_hl, { "Normal", #ico_txt + (fn_start and #fn_start or 0), -1 })
        btn.opts.hl = fb_hl
        table.insert(buttons, btn)
    end
    return buttons
end

local section_recent_files = {
    type = "group",
    val = {
        {
            type = "text",
            val = "  Recent Files",
            opts = {
                hl = "AlphaSection",
                position = "center",
                shrink_margin = false,
            },
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            val = function()
                return get_recent_files_buttons()
            end,
            opts = { shrink_margin = false },
        },
    },
}

-- Configure Layout: Header (with right-side shortcuts) -> Recent Folders -> Recent Files
theta.config.layout = {
    { type = "padding", val = 1 },
    theta.header,
    { type = "padding", val = 2 },
    section_recent_dirs,
    { type = "padding", val = 2 },
    section_recent_files,
    { type = "padding", val = 1 },
}

-- Keymaps on Alpha Dashboard Buffer
local keymaps = {
    ["f"] = "<cmd>FzfLua files<cr>",
    ["n"] = "<cmd>ene <BAR> startinsert<cr>",
    ["r"] = "<cmd>FzfLua oldfiles<cr>",
    ["g"] = "<cmd>FzfLua live_grep<cr>",
    ["o"] = "<cmd>Oil<cr>",
    ["c"] = "<cmd>FzfLua files cwd=~/.config/nvim<cr>",
    ["q"] = "<cmd>qa<cr>",
}

for key, cmd in pairs(keymaps) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function(ev)
            vim.keymap.set("n", key, cmd, { buffer = ev.buf, nowait = true, silent = true })
        end,
    })
end

alpha.setup(theta.config)
