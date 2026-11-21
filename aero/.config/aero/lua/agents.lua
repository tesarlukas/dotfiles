require('claudecode').setup {
  terminal = {
    provider = 'native',
    split_side = 'right',
    split_width_percentage = 0.35,
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'claudecode',
  callback = function(args)
    vim.keymap.set('t', '<Esc>', '<Esc>', { buffer = args.buf, nowait = true, desc = 'Escape goes to Claude' })
    vim.keymap.set(
      't',
      '<C-h>',
      '<C-\\><C-n><C-w>h',
      { buffer = args.buf, desc = 'Leave Claude, go to the window on the left' }
    )
    -- like tmux copy mode: stop typing and scroll with Vim motions, `i` goes back to typing
    vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', { buffer = args.buf, desc = 'Scroll in Claude output' })
    -- lines of output kept for scrolling back; 100000 is the most Neovim allows
    vim.bo[args.buf].scrollback = 100000
  end,
})

vim.keymap.set('n', '<leader>cc', '<Cmd>ClaudeCode<CR>', { desc = 'Launch Claude Code' })

-- It is sent to the Claude in this Neovim as `@file#L10-20 your words`.
vim.keymap.set('x', '<leader>ci', function()
  local first, last = vim.fn.line 'v', vim.fn.line '.'
  if first > last then
    first, last = last, first
  end
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
  local lines = first == last and tostring(first) or (first .. '-' .. last)
  vim.api.nvim_feedkeys(vim.keycode '<Esc>', 'nx', false) -- leave visual mode

  vim.ui.input({ prompt = 'Claude: ' }, function(instruction)
    if not instruction or instruction == '' then
      return
    end
    local sent = require('claudecode.terminal').send_to_terminal(string.format('@%s#L%s %s', file, lines, instruction))
    if not sent then
      vim.notify('Claude is not running in this Neovim. Start it with <leader>cc.', vim.log.levels.WARN)
    end
  end)
end, { desc = 'Send an instruction about the selected lines to Claude' })
