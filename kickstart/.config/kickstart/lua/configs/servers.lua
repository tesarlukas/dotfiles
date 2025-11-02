local methods = require 'configs.lspconfig'

local on_attach = methods.on_attach
local on_init = methods.on_init
local capabilities = methods.capabilities

local servers = {
  'html',
  'cssls',
  -- "clangd",
  'jsonls',
  'graphql',
  'eslint'
  -- "rust_analyzer",
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

-- Configure jsonls separately to disable formatting (Biome handles it)
vim.lsp.config('jsonls', {
  on_init = on_init,
  on_attach = function(client, bufnr)
    -- Disable JSON LSP formatting since we're using Biome
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})
vim.lsp.enable('jsonls')

require('typescript-tools').setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'javascriptreact', 'typescriptreact', 'javascript', 'typescript', 'graphql' },
}

vim.lsp.config('tailwindcss', {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'javascriptreact', 'typescriptreact', 'javascript', 'typescript', 'graphql' },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { 'tv\\((([^()]*|\\([^()]*\\))*)\\)' },
          { '["\'`]([^"\'`]*).*?["\'`]' },
        },
      },
    },
  },
})
vim.lsp.enable('tailwindcss')

vim.lsp.config('julials', {
  on_init = on_init,
  -- on_attach = function(client, bufnr)
  --   on_attach(client, bufnr)
  --
  --   -- Debug handler for diagnostics
  --   client.handlers['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
  --     print('Received diagnostics:', vim.inspect(result.diagnostics))
  --     vim.lsp.handlers['textDocument/publishDiagnostics'](_, result, ctx, config)
  --   end
  -- end,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    -- Enable StaticLint diagnostics
    julia = {
      lint = {
        enabled = true,
        run = 'true',
        missingrefs = 'all',
        type = true,      -- This might be key
        signature = true, -- And this
      },
      format = {
        indent = 4,
      },
    },
  },
})
vim.lsp.enable('julials')

vim.lsp.config('emmet_ls', {
  capabilities = capabilities,
  filetypes = {
    'html',
    'javascript',
    'javascriptreact',
    'svelte',
    'typescriptreact',
    'tsx',
    'jsx',
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ['bem.enabled'] = true,
      },
    },
  },
})
vim.lsp.enable('emmet_ls')

capabilities.textDocument.completion.completionItem.snippetSupport = true
