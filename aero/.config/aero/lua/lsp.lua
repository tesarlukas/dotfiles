vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = { 'lua/?.lua', 'lua/?/init.lua' } },
      workspace = { library = { vim.env.VIMRUNTIME } },
    },
  },
})

-- dropped from the old config: emmet_ls, graphql, gopls, postgres_lsp, tailwindcss
vim.lsp.enable { 'lua_ls', 'ts_ls', 'eslint', 'jsonls' }

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Go to definition' })
  end,
})
