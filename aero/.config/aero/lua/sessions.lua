local enabled = true
local dir = vim.fn.stdpath 'state' .. '/sessions/'

-- one session file per working directory, named by a hash of the path, so each project remembers its own state.
local function session_file()
  return dir .. vim.fn.sha256(vim.fn.getcwd()) .. '.vim'
end

-- on quit, save the session, but only if Neovim was started without a file. nvim somefile and git commit never touch it.
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    if enabled and vim.fn.argc() == 0 then
      vim.fn.mkdir(dir, 'p')
      vim.cmd('mksession! ' .. session_file())
    end
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  nested = true,
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.filereadable(session_file()) == 1 then
      vim.cmd('source ' .. session_file())
    end
  end,
})

-- create SessionDelete command
vim.api.nvim_create_user_command('SessionDelete', function()
  local deleted = vim.fn.delete(session_file()) == 0
  enabled = false
  vim.notify(deleted and 'Session deleted' or 'No session for this directory')
end, { desc = 'Delete the session of this directory' })
