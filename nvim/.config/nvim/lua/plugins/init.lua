return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("configs.conform")
		end,
	},

	{
		event = { "BufReadPre", "BufNewFile" },
		"mfussenegger/nvim-lint",
		config = function()
			require("configs.nvim-lint")
		end,
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = "single",
			},
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
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
			},
		},
	},

	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"tpope/vim-fugitive",
		lazy = false,
	},

	{
		"nvim-pack/nvim-spectre",
		event = "VeryLazy",
	},

	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("auto-session").setup({})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		opts = function()
			local conf = require("nvchad.configs.telescope")

			conf.defaults.file_ignore_patterns = {
				"node_modules",
				".git",
			}
			conf.defaults.mappings = {
				n = {
					["dd"] = require("telescope.actions").delete_buffer,
				},
			}

			return conf
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = function()
			require("configs.nvim-tree")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local conf = require("nvchad.configs.cmp")

			conf.sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				-- { name = "buffer" },
				{ name = "nvim_lua" },
				{ name = "path" },
			}

			return conf
		end,
	},

	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	{
		"cbochs/grapple.nvim",
	},

	{
		"kwkarlwang/bufjump.nvim",
	},

	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	lazy = false,
	-- 	branch = "v3.x",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		-- "nvim-tree/nvim-web-devicons",
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("neo-tree").setup({
	-- 			follow_current_file = {
	-- 				enabled = true,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"mistricky/codesnap.nvim",
	-- 	build = "make build_generator",
	-- 	keys = {
	-- 		{ "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
	-- 		{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
	-- 	},
	-- 	opts = {
	-- 		save_path = "~/Pictures",
	-- 		has_breadcrumbs = true,
	-- 		bg_padding = 4,
	-- 		watermark = "",
	-- 	},
	-- },

	-- {
	-- 	"epwalsh/obsidian.nvim",
	-- 	event = {
	-- 		"BufReadPre /media/oem/MoreStuff/ObsidianVault/MyVault/**.md",
	-- 		"BufNewFile /media/oem/MoreStuff/ObsidianVault/MyVault/**.md",
	-- 	},
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("configs.obsidian")
	-- 	end,
	-- },

	-- {
	-- 	"lervag/vimtex",
	-- 	lazy = true,
	-- 	init = function()
	-- 		vim.g.vimtex_view_method = "zathura"
	-- 	end,
	-- },

	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	--    lazy = false,
	-- 	config = function()
	-- 		require("supermaven-nvim").setup({
	-- 			keymaps = {
	-- 				accept_suggestion = "<A-l>",
	-- 				clear_suggestion = "<A-;>",
	-- 				accept_word = "<A-o>",
	-- 			},
	-- 			ignore_filetypes = { cpp = true },
	-- 			color = {
	-- 				suggestion_color = "#545454",
	-- 				cterm = 244,
	-- 			},
	-- 			log_level = "info", -- set to "off" to disable logging completely
	-- 			disable_inline_completion = false, -- disables inline completion for use with cmp
	-- 			disable_keymaps = false, -- disables built in keymaps for more manual control
	-- 		})
	-- 	end,
	-- },
	{
		"rktjmp/lush.nvim",
		lazy = false,
	},
}
