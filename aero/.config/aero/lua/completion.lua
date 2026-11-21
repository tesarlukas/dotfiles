require('blink.cmp').setup {
  keymap = { preset = 'default' },
  completion = {
    menu = {
      border = 'none',
      draw = { padding = 1 },
    },
  },
}

require('nvim-autopairs').setup()
