local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.prettierd,
  formatting.stylua,

  lint.shellcheck,
  lint.eslint_d,
}

null_ls.setup {
  debug = true,
  sources = sources,
  -- on_attach = function()
  --   vim.api.nvim_create_autocmd("BufWritePost", {
  --     callback = function()
  --       vim.lsp.buf.format()
  --     end,
  --   })
  -- end,
}
