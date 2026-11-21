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
    -- `nowait` makes gr fire at once; it takes the place of Neovim's own grr, grn and gra here
    vim.keymap.set('n', 'gr', function()
      require('telescope.builtin').lsp_references()
    end, { buffer = args.buf, nowait = true, desc = 'References' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf, desc = 'Code action' })
  end,
})
