-- previous / next file through the jumplist, skipping jumps inside the current file
-- step = -1 goes back, step = 1 goes forward
local function jump_to_other_file(step)
  local jumps, pos = unpack(vim.fn.getjumplist())
  local here = vim.api.nvim_get_current_buf()
  local start = pos + 1 -- the jumplist position is 0-based, Lua lists are 1-based

  local function other(i)
    return jumps[i] and jumps[i].bufnr ~= here and vim.api.nvim_buf_is_valid(jumps[i].bufnr)
  end

  local i = start + step
  while jumps[i] and not other(i) do
    i = i + step
  end
  if not jumps[i] then
    return
  end

  -- going forward, land on the newest position in that file, not the oldest
  while step == 1 and jumps[i + 1] and jumps[i + 1].bufnr == jumps[i].bufnr do
    i = i + 1
  end

  local key = step == -1 and '<C-o>' or '<C-i>'
  vim.cmd('normal! ' .. math.abs(i - start) .. vim.keycode(key))
end

vim.keymap.set('n', '<C-o>', function()
  jump_to_other_file(-1)
end, { desc = 'Back to the previous file' })

vim.keymap.set('n', '<C-p>', function()
  jump_to_other_file(1)
end, { desc = 'Forward to the next file' })

-- grapple: a short list of tagged files per git repo
local grapple = require 'grapple'

vim.keymap.set('n', '<leader>h', grapple.toggle, { desc = 'Tag or untag this file' })
vim.keymap.set('n', '<leader>H', grapple.toggle_tags, { desc = 'Show tagged files' })

for i = 1, 4 do
  vim.keymap.set(
    'n',
    '<leader>' .. i,
    '<cmd>Grapple select index=' .. i .. '<CR>',
    { desc = 'Go to tagged file ' .. i }
  )
end

vim.keymap.set('n', '<Tab>', '<cmd>Grapple cycle_tags next<CR>', { desc = 'Next tagged file' })
vim.keymap.set('n', '<S-Tab>', '<cmd>Grapple cycle_tags prev<CR>', { desc = 'Previous tagged file' })
