local function centered()
  local width = math.floor(vim.o.columns * 0.5)
  local height = math.floor(vim.o.lines * 0.8)
  return {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2) - 1,
  }
end

require('nvim-tree').setup {
  view = {
    number = true,
    relativenumber = true,
    float = { enable = true, open_win_config = centered },
  },
  update_focused_file = { enable = true },
  git = { enable = false },
}

vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle File Tree' })
