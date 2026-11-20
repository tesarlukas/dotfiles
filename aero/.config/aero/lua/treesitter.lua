require('nvim-treesitter').install {
  'typescript',
  'tsx',
  'javascript',
  'json',
  'yaml',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
