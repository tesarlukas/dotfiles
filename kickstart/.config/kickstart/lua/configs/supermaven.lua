local M = {}

function M.setup()
  -- Configure Supermaven to not show suggestions automatically
  require('supermaven-nvim').setup {
    keymaps = {
      accept_suggestion = '<Right>',
      clear_suggestion = '<Left>',
      accept_word = '<Down>',
    },
    ignore_filetypes = { cpp = true },
    color = {
      suggestion_color = '#4e565c',
      cterm = 244,
    },
    log_level = 'info',
    disable_inline_completion = false,
    disable_keymaps = false,
  }
end

return M
