local options = {
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		javascriptreact = { "prettierd" },
		json = { "prettierd" },
    yaml = { "prettierd", "biome" },
    python = { "black" },
    graphql = { "prettierd" }
	},
}

require("conform").setup(options)
