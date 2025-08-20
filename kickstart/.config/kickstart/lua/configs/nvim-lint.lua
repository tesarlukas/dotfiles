local M = {}

function M.setup()
  local lint = require 'lint'
  lint.linters_by_ft = {
    typescript = { 'eslint_d', 'cspell' },
    javascript = { 'eslint_d', 'cspell' },
    typescriptreact = { 'eslint_d', 'cspell' },
    javascriptreact = { 'eslint_d', 'cspell' },
  }

  -- Create autocommand which carries out the actual linting
  -- on the specified events.
  local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
