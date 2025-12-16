local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.notify('Installing lazy.nvim ...')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { 'nvim-tree/nvim-web-devicons' }, --file icons
    { 'tpope/vim-commentary' },
    {
        'akinsho/bufferline.nvim',
        config = function()
            require('plugins.bufferline').setup()
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('plugins.lualine').setup()
        end
    },
    { 'tpope/vim-fugitive' }, --git
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' },
    { 'airblade/vim-gitgutter' },
    {
        'mhinz/vim-startify',
        config = function()
            require('plugins.vim-startify').setup()
        end
    },
    { 'voldikss/vim-floaterm' }, --terminal
    {
        'luochen1990/rainbow',
        config = function()
            require('plugins.rainbow').setup()
        end
    }, --colorful brackets

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-org/mason.nvim',
            'mason-org/mason-lspconfig.nvim',
        },
        config = function()
            require('plugins.nvim-lspconfig').setup()
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer'
        },
        config = function()
            require('plugins.nvim-cmp').setup()
        end
    },
    {
        'SmiteshP/nvim-navic',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        config = function()
            require('plugins.nvim-navic').setup()
        end
    },

    {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
            'neovim/nvim-lspconfig',
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim',
        },
        config = function ()
            require('plugins.nvim-navbuddy').setup()
        end
    },

    -- {
    -- 'nvim-treesitter/nvim-treesitter',
    -- build = ':TSUpdate',
    -- config = function()
    --   require('nvim-treesitter.configs').setup({
    --     ensure_installed = { 'rust', 'lua', 'vimdoc', 'c', 'cpp' },
    --     highlight = { enable = true },
    --     indent = { enable = true },
    --   })
    -- end,
    -- },

    --colorcheme
    { 'folke/tokyonight.nvim' },
    { 'morhetz/gruvbox' },
    { 'joshdick/onedark.vim' },
    { 'tomasr/molokai' },
    { 'dracula/vim' },
    -- use('flazz/vim-colorschemes') --a colorscheme pack

    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('plugins.nvim-tree').setup()
        end
    },

    -- leetcode --
    {
        'kawre/leetcode.nvim',
        build = ':TSUpdate html',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim', -- required by telescope
            'MunifTanjim/nui.nvim',

            -- optional
            -- 'nvim-treesitter/nvim-treesitter',
            'rcarriga/nvim-notify',
            -- 'nvim-tree/nvim-web-devicons',
        },
        opts = {
            -- configuration goes here
        },
        config = function()
            require('plugins.leetcode').setup()
        end
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        ---@module 'ibl'
        ---@type ibl.config
        opts = {}
    },

    -- rust --
    { 'rust-lang/rust.vim' },
    {
        'saecki/crates.nvim',
        tag = 'stable',
        event = { "BufRead Cargo.toml" },
        opts = {
            completion = {
                crates = {
                    enabled = true
                }
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true
            }
        },
        config = function()
            require('crates').setup()
        end,
    },
    -- {
    --     'mrcjkb/rustaceanvim',
    --     version = '^6', -- Recommended
    --     lazy = false, -- This plugin is already lazy
    -- },

    -- debug --
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            require('plugins.dap').setup()
        end
    },

    { 'tpope/vim-surround' },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.nvim',
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
        opts = {
            only_render_image_at_cursor = true
        },
        config = function()
            require('plugins.render-markdown').setup()
        end
    },
    {
        'folke/snacks.nvim',
        ---@type snacks.Config
        opts = {
            image = {}
        },
        config = function()
            require('plugins.snacks').setup()
        end
    }
})
