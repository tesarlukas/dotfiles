local M = {}

function M.setup()
  -- Configure Supermaven to not show suggestions automatically
  require('supermaven-nvim').setup {
    keymaps = {
      accept_suggestion = '<A-l>',
      clear_suggestion = '<A-k>',
      accept_word = '<A-j>',
    },
    ignore_filetypes = { cpp = true },
    color = {
      suggestion_color = '#4e565c',
      cterm = 244,
    },
    log_level = 'info',
    disable_inline_completion = false,
    disable_keymaps = false,
    condition = function()
      return true -- This disables automatic suggestions (true = stop Supermaven)
    end,
  }
end

return M
