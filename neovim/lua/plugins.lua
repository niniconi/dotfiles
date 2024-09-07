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
    {
        'nvim-tree/nvim-tree.lua',
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    },

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
})

-- import plugins conf
require("plugins.vim-startify")
require("plugins.nvim-tree")
require("plugins.lualine")
require("plugins.bufferline")
require("plugins.rainbow")
require("plugins.leetcode")
