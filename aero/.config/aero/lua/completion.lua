require('blink.cmp').setup {
  keymap = {
    preset = 'enter',
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
  },
  completion = {
    menu = {
      border = 'none',
      draw = { padding = 1 },
    },
  },
  sources = {
    providers = {
      path = {
        enabled = function()
          -- remove path autocompletion
          local web = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }
          return not vim.tbl_contains(web, vim.bo.filetype)
        end,
      },
    },
  },
}

require('nvim-autopairs').setup()
