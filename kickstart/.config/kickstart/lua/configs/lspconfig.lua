local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = 'LSP ' .. desc }
  end

  map('n', 'gd', require('telescope.builtin').lsp_definitions, opts '[G]oto [D]efinition')
  map('n', 'gr', require('telescope.builtin').lsp_references, opts '[G]oto [R]eferences')
  map('n', 'gI', require('telescope.builtin').lsp_implementations, opts '[G]oto [I]mplementation')
  map('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, opts 'Type [D]efinition')
  map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, opts '[D]ocument [S]ymbols')
  map('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts '[W]orkspace [S]ymbols')
  map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts '[C]ode [A]ctions')
  map('n', '<leader>rn', vim.lsp.buf.rename, opts '[R]e[n]ame')
  map('n', 'gD', vim.lsp.buf.declaration, opts '[G]oto [D]eclaration')

  -- Add cursor highlight functionality
  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = bufnr }
      end,
    })
  end
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client:supports_method 'textDocument/semanticTokens' then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { 'markdown', 'plaintext' },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  },
}

M.defaults = function()
  dofile(vim.g.base46_cache .. 'lsp')
  require('nvchad.lsp').diagnostic_config()

  vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    on_init = M.on_init,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            vim.fn.expand '$VIMRUNTIME/lua',
            vim.fn.expand '$VIMRUNTIME/lua/vim/lsp',
            vim.fn.stdpath 'data' .. '/lazy/ui/nvchad_types',
            vim.fn.stdpath 'data' .. '/lazy/lazy.nvim/lua/lazy',
            '${3rd}/luv/library',
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })

  vim.lsp.enable('lua_ls')
end

return M

--   require('typescript-tools').setup {
--     on_init = on_init,
--     capabilities = capabilities,
--   }
--
--   -- Ensure the servers and tools above are installed
--   --  To check the current status of installed tools and/or manually install
--   --  other tools, you can run
--   --    :Mason
--   --
--   --  You can press `g?` for help in this menu.
--   require('mason').setup()
--
--   -- You can add other tools here that you want Mason to install
--   -- for you, so that they are available from within Neovim.
--   local ensure_installed = vim.tbl_keys(servers or {})
--   vim.list_extend(ensure_installed, {
--     'stylua', -- Used to format Lua code
--     'cspell',
--     'emmet-ls',
--     'graphql-language-service-cli',
--     'json-lsp',
--     'lua-language-server',
--     -- 'prettier',
--     'prettierd',
--     -- 'eslint',
--     'eslint_d',
--     'stylua',
--     'tailwindcss-language-server',
--   })
--   require('mason-tool-installer').setup { ensure_installed = ensure_installed }
--
--   require('mason-lspconfig').setup {
--     handlers = {
--       function(server_name)
--         local server = servers[server_name] or {}
--         -- This handles overriding only values explicitly passed
--         -- by the server configuration above. Useful when disabling
--         -- certain features of an LSP (for example, turning off formatting for ts_ls)
--         server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
--         server.on_init = on_init
--         require('lspconfig')[server_name].setup(server)
--       end,
--     },
--   }
-- end
--
-- return M
