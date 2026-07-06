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
  { "nvim-tree/nvim-web-devicons" }, --file icons
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("plugins.bufferline").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine").setup()
    end,
  },
  { "tpope/vim-fugitive" }, --git
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns").setup()
    end,
  },
  { "HiPhish/rainbow-delimiters.nvim" },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("plugins.nvim-lspconfig").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      require("plugins.nvim-cmp").setup()
    end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("plugins.nvim-navic").setup()
    end,
  },

  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins.nvim-navbuddy").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter").setup()
    end,
  },

  --colorcheme
  { "folke/tokyonight.nvim" },
  { "morhetz/gruvbox" },
  { "joshdick/onedark.vim" },
  { "tomasr/molokai" },
  { "dracula/vim" },
  { "RRethy/base16-nvim" },
  -- use('flazz/vim-colorschemes') --a colorscheme pack

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.neo-tree").setup()
    end,
  },

  -- leetcode --
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      -- 'nvim-treesitter/nvim-treesitter',
      "rcarriga/nvim-notify",
      -- 'nvim-tree/nvim-web-devicons',
    },
    opts = {
      -- configuration goes here
    },
    config = function()
      require("plugins.leetcode").setup()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module 'ibl'
    ---@type ibl.config
    opts = {
      indent = { char = "┊" },
      scope = {
        enabled = true,
        include = { node_type = { ["*"] = { "*" } } },
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "neo-tree",
          "lazy",
          "TelescopePrompt",
          "NvimTree",
        },
      },
    },
  },

  -- rust --
  { "rust-lang/rust.vim" },
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
    config = function()
      require("crates").setup()
    end,
  },
  -- {
  --     'mrcjkb/rustaceanvim',
  --     version = '^6', -- Recommended
  --     lazy = false, -- This plugin is already lazy
  -- },

  -- debug --
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("plugins.dap").setup()
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- adapters
      "rouge8/neotest-rust",
    },
    config = function()
      require("plugins.neotest").setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "^3.1.8",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
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
      only_render_image_at_cursor = true,
    },
    config = function()
      require("plugins.render-markdown").setup()
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("headlines").setup(opts)
    end,
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = {},
    },
    config = function()
      require("plugins.snacks").setup()
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 500,
      icons = { mappings = true },
      filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
      end,
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = true, suggestions = 20 },
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = true,
          nav = false,
          z = false,
          g = false,
        },
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
        wo = { winblend = 10 },
        width = 40,
        height = { min = 5, max = 50 },
        row = math.huge,
        col = math.huge,
      },
      layout = {
        spacing = 3,
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function(_, opts)
      require("which-key").setup(opts)
      require("plugins.which-key").setup()
    end,
  },
})
