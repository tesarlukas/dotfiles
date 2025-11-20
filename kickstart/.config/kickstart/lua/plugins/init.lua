return {
  'nvim-lua/plenary.nvim',

  {
    'nvchad/ui',
    config = function()
      require 'nvchad'
    end,
  },

  {
    'nvchad/base46',
    lazy = true,
    build = function()
      require('base46').load_all_highlights()
    end,
  },

  {
    'pmizio/typescript-tools.nvim',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  },

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'Bilal2453/luvit-meta',
    lazy = true
  },

  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    event = 'User FilePost',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      -- { 'j-hui/fidget.nvim', opts = {} },
      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('configs.lspconfig').defaults()
      require 'configs.servers'
    end,
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fm',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = require 'configs.conform',
  },

  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },

      {
        'windwp/nvim-autopairs',
        lazy = true,
        dependencies = { 'hrsh7th/nvim-cmp' },
        opts = {
          fast_wrap = {},
          disable_filetype = { 'TelescopePrompt', 'vim' },
        },
        config = function(_, opts)
          require('nvim-autopairs').setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
          require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      require('configs.cmp').setup()
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    cmd = { 'NvimTreeToggle' },
    config = function()
      require('configs.nvim-tree').setup()
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'User FilePost',
    opts = {
      indent = { char = '│', highlight = 'IblChar' },
      scope = { char = '│', highlight = 'IblScopeChar' },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. 'blankline')

      local hooks = require 'ibl.hooks'
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require('ibl').setup(opts)

      dofile(vim.g.base46_cache .. 'blankline')
    end,
  },

  {
    'williamboman/mason.nvim',
    lazy = true,
    opts = function()
      require 'configs.mason'
    end,
  },

  -- {
  --   'windwp/nvim-autopairs',
  --   lazy = true,
  --   -- Optional dependency
  --   dependencies = { 'hrsh7th/nvim-cmp' },
  --   config = function()
  --     require('nvim-autopairs').setup {}
  --     -- If you want to automatically add `(` after selecting a function or method
  --     local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
  --     local cmp = require 'cmp'
  --     cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  --   end,
  -- },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = require 'configs.treesitter',
    dependencies = {
      'windwp/nvim-ts-autotag',
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    evetn = 'User FilePost',
    opts = require 'configs.gitsigns',
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = require 'configs.whichkey',
  },

  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font
      },
    },
    config = function()
      require('configs.telescope').setup()
    end,
  },

  { -- Linting
    'mfussenegger/nvim-lint',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('configs.nvim-lint').setup()
    end,
  },

  -- Auto-Session
  {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
      require('auto-session').setup {}
    end,
  },

  -- Navigation
  {
    'cbochs/grapple.nvim',
    lazy = true,
  },

  {
    'kwkarlwang/bufjump.nvim',
    lazy = true,
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    'sindrets/vim-fugitive',
    event = 'VeryLazy',
    cmd = { 'Git' },
  },

  { 'tpope/vim-surround' },

  {
    'NvChad/volt',
    lazy = true,
  },

  -- {
  --   'decaycs/decay.nvim',
  --   lazy = true,
  -- },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    lazy = true,
    ft = 'markdown',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("configs/supermaven").setup()
    end,
  },

  -- TODO: temporarily disable obsidian as it is not setupn new Mac
  -- {
  --   'epwalsh/obsidian.nvim',
  --   version = '*',
  --   lazy = true,
  --   ft = 'markdown',
  --   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  --   event = {
  --     -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --     -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --     -- refer to `:h file-pattern` for more examples
  --     'BufReadPre '
  --       .. vim.fn.expand '~'
  --       .. '/Dropbox/my_vault/*.md',
  --     'BufNewFile ' .. vim.fn.expand '~' .. '/Dropbox/my_vault/*.md',
  --   },
  --   dependencies = {
  --     -- Required.
  --     'nvim-lua/plenary.nvim',
  --
  --     -- see below for full list of optional dependencies 👇
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = 'myvault',
  --         path = '~/Documents/obsidian/my_vault/',
  --       },
  --     },
  --     daily_notes = {
  --       -- Optional, if you keep daily notes in a separate directory.
  --       folder = 'Daily notes',
  --       -- Optional, if you want to change the date format for the ID of daily notes.
  --       date_format = '%Y-%m-%d',
  --       -- Optional, if you want to change the date format of the default alias of daily notes.
  --       alias_format = '%B %-d, %Y',
  --       -- Optional, default tags to add to each new daily note created.
  --       default_tags = { 'daily-notes' },
  --       -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
  --       template = nil,
  --     },
  --
  --     templates = {
  --       folder = 'Templates',
  --     },
  --     -- see below for full list of options 👇
  --   },
  -- },

  {
    'tpope/vim-sleuth',
  },

  {
    'sindrets/diffview.nvim',
    -- lazy = true
  },

  {
    'tpope/vim-rhubarb'
  }

  -- 'dstein64/vim-startuptime', -- just uncomment if measuring
}
