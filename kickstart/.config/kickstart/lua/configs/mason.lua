dofile(vim.g.base46_cache .. 'mason')

require('mason').setup()

return {
  PATH = 'skip',

  ui = {
    icons = {
      package_pending = ' ',
      package_installed = ' ',
      package_uninstalled = ' ',
    },
  },
  ensure_installed = {
    'stylua', -- Used to format Lua code
    'cspell',
    'emmet-ls',
    'graphql-language-service-cli',
    'json-lsp',
    'lua-language-server',
    -- 'prettier',
    'prettierd',
    -- 'eslint',
    'eslint_d',
    'stylua',
    'tailwindcss-language-server',
  },

  max_concurrent_installers = 10,
}
