local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify("Installing Pakcer.nvim ...")
    paccker_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })

    local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
    if not string.find(vim.o.runtimepath, rtp_addition) then
        vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
    end
    vim.notify("Pakcer.nvim is installed")
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("not install packer.nvim")
    return
end

packer.startup({
    function(use)
        use("wbthomason/packer.nvim") --auto upgrade the packer
        use("tpope/vim-commentary")
        use {
            'akinsho/bufferline.nvim',
            tag = "v3.*",
            requires = 'nvim-tree/nvim-web-devicons'
        }
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        use("tpope/vim-fugitive") --git
        use {
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
            },
            tag = 'nightly' -- optional, updated every week. (see issue #1193)
        }
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.1',
            requires = { {'nvim-lua/plenary.nvim'} }
        }
        use("airblade/vim-gitgutter")
        use("mhinz/vim-startify")
        use("voldikss/vim-floaterm") --terminal
        --lsp
        use {"neoclide/coc.nvim", branch = "release"}

        --colorcheme
        use("folke/tokyonight.nvim")
        use("morhetz/gruvbox")
        use("joshdick/onedark.vim")
        use("tomasr/molokai")
        use("dracula/vim")
        -- use("flazz/vim-colorschemes") --a colorscheme pack
        if paccker_bootstrap then
            packer.sync()
        end
    end,
    config = {
        -- 锁定插件版本在snapshots目录
        snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
        -- 这里锁定插件版本在v1，不会继续更新插件
        snapshot = "v1",
        -- 最大并发数
        max_jobs = 16,
        -- 自定义源
        git = {
          -- default_url_format = "https://hub.fastgit.xyz/%s",
          -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
          -- default_url_format = "https://gitcode.net/mirrors/%s",
          -- default_url_format = "https://gitclone.com/github.com/%s",
        },
        display = {
        -- 使用浮动窗口显示
          open_fn = function()
            return require("packer.util").float({ border = "single" })
          end,
        },
    },
})

-- import plugins conf
require("plugins.vim-startify")
require("plugins.nvim-tree")
require("plugins.lualine")
require("plugins.bufferline")
