local map = vim.keymap.set

-- makes the paste over something not send it to the copy register 
map('x', '<leader>p', [["_dP]])

-- don't change the position of the cursor when pressing J
map('n', 'J', 'mzJ`z')

-- staying in the middle while using vertical navigation
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

-- clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- diagnostics
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'LSP floating diagnostics' })

-- split navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- quickfix list
map('n', '<A-]>', '<CMD>cnext<CR>', { desc = 'Quickfix List Next' })
map('n', '<A-[>', '<CMD>cprev<CR>', { desc = 'Quickfix List Prev' })

-- turn off the H and L default behaviour
map('n', 'H', '<Nop>')
map('n', 'L', '<Nop>')

-- LSP restart
map('n', '<leader>lsr', ':lsp restart<CR>')

