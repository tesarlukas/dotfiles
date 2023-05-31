local plugins = {
  {
    "vim-crystal/vim-crystal",
    ft = "crystal",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "custom-elements-languageserver",
        "css-lsp",
        "eslint_d",
        "prettier",
        "prettierd",
        "emmet-ls",
        "gitlint",
      },
    },
  },
  {
    "andweeb/presence.nvim",
    lazy = false,
    config = function()
      require("presence").setup {
        auto_update = true,
        neovim_image_text = "BASED",
        main_image = "neovim",
        -- client_id = "793271441293967371",
        debounce_timeout = 10,
        enable_line_number = false,
        blacklist = {},
        buttons = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        show_time = true,
      }
    end,
  },
  {
    "nvim-treesitter/playground",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup {}
    end,
  },
  {
    "sindrets/vim-fugitive",
    lazy = false,
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = function()
      require("plugins.configs.treesitter")
    end,
  },
}
return plugins
