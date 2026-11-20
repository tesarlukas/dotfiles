require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    typescript = { 'prettierd' },
  },
}

vim.keymap.set('', '<leader>fm', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]or[m]at Buffer' })
