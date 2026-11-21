require('render-markdown').setup {}

local lint = require 'lint'

lint.linters_by_ft = {
  markdown = { 'cspell' },
  typescript = { 'cspell' },
  javascript = { 'cspell' },
  typescriptreact = { 'cspell' },
  javascriptreact = { 'cspell' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
  group = vim.api.nvim_create_augroup('spelling', { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})
