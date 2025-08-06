local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.notify("Installing lazy.nvim ...")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {'nvim-tree/nvim-web-devicons'}, --file icons
    {"tpope/vim-commentary"},
    {'akinsho/bufferline.nvim'},
    {'nvim-lualine/lualine.nvim'},
    {"tpope/vim-fugitive"}, --git
    {'nvim-lua/plenary.nvim'},
    {'nvim-telescope/telescope.nvim'},
    {"airblade/vim-gitgutter"},
    {"mhinz/vim-startify"},
    {"voldikss/vim-floaterm"}, --terminal
    {"neoclide/coc.nvim", branch = "release"},--lsp
    {"luochen1990/rainbow"}, --colorful brackets

    --colorcheme
    {"folke/tokyonight.nvim"},
    {"morhetz/gruvbox"},
    {"joshdick/onedark.vim"},
    {"tomasr/molokai"},
    {"dracula/vim"},
    -- use("flazz/vim-colorschemes") --a colorscheme pack

    {'nvim-tree/nvim-tree.lua'},

    -- leetcode --
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            -- "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
            -- "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- configuration goes here
        }
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {}
    },

    -- rust --
    {'rust-lang/rust.vim'},

    -- debug --
    {"mfussenegger/nvim-dap"},

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.nvim'
        }, -- if you use the mini.nvim suite
        -- dependencies = {
            -- 'nvim-treesitter/nvim-treesitter',
            -- 'echasnovski/mini.icons'
        -- }, -- if you use standalone mini plugins
        -- dependencies = {
            -- 'nvim-treesitter/nvim-treesitter',
            -- 'nvim-tree/nvim-web-devicons' 
        -- },-- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "folke/snacks.nvim",
        ---@type snacks.Config
        opts = {
            image = {}
        }
    }
})

local function load_plugin_config(modname)
    local status, result = pcall(require,modname)
    if not status then
        print("load plugin config failed：", result)
    end

end

-- import plugins conf
load_plugin_config("plugins.vim-startify")
load_plugin_config("plugins.nvim-tree")
load_plugin_config("plugins.lualine")
load_plugin_config("plugins.bufferline")
load_plugin_config("plugins.rainbow")
load_plugin_config("plugins.leetcode")
load_plugin_config("plugins.dap")
load_plugin_config("plugins.render-markdown")
load_plugin_config("plugins.snacks")
