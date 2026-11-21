require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    json = { 'prettierd' },
    jsonc = { 'prettierd' },
    yaml = { 'prettierd' },
  },
}

vim.keymap.set('', '<leader>fm', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]or[m]at Buffer' })
