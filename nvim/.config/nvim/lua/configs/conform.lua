local options = {
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		javascriptreact = { "prettier" },
		json = { "prettier" },
    yaml = { "prettier", "biome" },
    python = { "black" },
    graphql = { "prettier" }
	},
}

require("conform").setup(options)
