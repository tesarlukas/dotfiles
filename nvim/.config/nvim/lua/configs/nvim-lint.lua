local lint = require("lint")

lint.linters_by_ft = {
	typescript = { "eslint_d", "cspell" },
	javascript = { "eslint_d", "cspell" },
	typescriptreact = { "eslint_d", "cspell" },
	javascriptreact = { "eslint_d", "cspell" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
	callback = function()
		lint.try_lint()
	end,
})
