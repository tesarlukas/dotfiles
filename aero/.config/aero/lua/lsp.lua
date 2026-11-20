vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = { 'lua/?.lua', 'lua/?/init.lua' } },
      workspace = { library = { vim.env.VIMRUNTIME } },
    },
  },
})

vim.lsp.enable 'lua_ls'

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Go to definition' })
  end,
})
