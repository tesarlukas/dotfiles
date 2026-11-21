local telescope = require 'telescope'
local builtin = require 'telescope.builtin'

telescope.setup {
  defaults = {
    file_ignore_patterns = { 'node_modules', 'yarn.lock', '%.snap', '%.git/' },
  },
  pickers = {
    find_files = { hidden = true },
  },
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
}

telescope.load_extension 'fzf'
telescope.load_extension 'ui-select'

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = '[F]ind [W]ord' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find open buffers' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })

vim.keymap.set('n', '<leader>fa', function()
  builtin.find_files { follow = true, no_ignore = true, hidden = true }
end, { desc = '[F]ind [A]ll files' })
