local map = vim.keymap.set
-- local del = vim.keymap.del

-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
-- Default mappings deletion
-- del('n', '<leader>/')
-- del('n', '<C-n>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

-- greatest remap ever
map('x', '<leader>p', [["_dP]])

-- don't change the position of the cursor when pressing J
map('n', 'J', 'mzJ`z')

-- staying in the middle
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- toggle comment
map('n', '<leader>/', 'gcc', { desc = 'Toggle Comment', remap = true })
map('v', '<leader>/', 'gc', { desc = 'Toggle comment', remap = true })

-- moving lines while they are selected
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Bufjump mappings
map('n', '<C-o>', ":lua require('bufjump').backward()<cr>")
map('n', '<C-p>', ":lua require('bufjump').forward()<cr>")

-- Toggle Nvim-Tree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')

-- GRAPPLE
map('n', '<leader>h', require('grapple').toggle)
map('n', '<leader>H', require('grapple').toggle_tags)
map('n', '<leader>1', '<cmd>Grapple select index=1<CR>')
map('n', '<leader>2', '<cmd>Grapple select index=2<CR>')
map('n', '<leader>3', '<cmd>Grapple select index=3<CR>')
map('n', '<leader>4', '<cmd>Grapple select index=4<CR>')
map('n', '<tab>', '<cmd>Grapple cycle_tags next scope=cwd<CR>')
map('n', '<S-tab>', '<cmd>Grapple cycle_tags previous scope=cwd<CR>')

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
-- See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--  NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- map('n', '<leader>fm', require('conform').format { async = true, lsp_format = 'fallback' }, { desc = '[F]ormat buffer' })

-- LSP diagnostics
map('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'LSP floating diagnostics' })
map('n', '<leader>ds', vim.diagnostic.setloclist, { desc = 'LSP diagnostic loclist' })

-- QuickFix list mappings
map('n', '<A-]>', '<CMD>cnext<CR>', { desc = 'Quickfix List Next' })
map('n', '<A-[>', '<CMD>cprev<CR>', { desc = 'Quickfix List Prev' })

-- Fugitive and GitSigns stuff
map('n', '<space>g', ':Git <CR>', { desc = 'Open [G]it integration' })
map('n', '<space>vd', ':Gvdiff <CR>')
map('n', '<leader>ss', ':Gitsigns stage_hunk<CR>')

-- Toggle transparency
map('n', '<leader>tt', function()
  require('base46').toggle_transparency()
end, { desc = 'Toggle transparency' })

-- Theme switcher
map('n', '<leader>th', function()
  require('nvchad.themes').open()
end, { desc = '[T][h]eme switcher' })

-- Typescript tools
map('n', '<leader>ru', '<cmd>TSToolsRemoveUnusedImports<CR>', { desc = '[R]emove [U]nused (TS)' })

-- Obsidian
map('n', '<leader>od', '<cmd>ObsidianDailies<CR>', { desc = '[O]bsidian [D]ailies'})
map('n', '<leader>ot', '<cmd>ObsidianTemplate<CR>', { desc = '[O]bsidian [T]emplates'})
