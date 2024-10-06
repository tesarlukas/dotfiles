local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = {
	"html",
	"cssls",
	-- "clangd",
	-- "tsserver",
	"jsonls",
	-- "volar",
	"graphql",
	-- "rust_analyzer",
	"tailwindcss",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_init = on_init,
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

require("typescript-tools").setup({
	on_init = on_init,
	on_attach = on_attach,
	capabilities = capabilities,
	-- root_dir = function(...)
	-- 	return require("lspconfig.util").root_pattern(".git")(...)
	-- end,
})

lspconfig.tailwindcss.setup({
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					{ "tv\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
				},
			},
		},
	},
})

lspconfig.emmet_ls.setup({
	-- on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"html",
		"javascript",
		"javascriptreact",
		"svelte",
		"typescriptreact",
		"tsx",
		"jsx",
	},
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})

-- lspconfig.tsserver.setup({
--   on_init = on_init,
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	root_dir = function(...)
-- 		return require("lspconfig.util").root_pattern(".git")(...)
-- 	end,
-- })

capabilities.textDocument.completion.completionItem.snippetSupport = true
