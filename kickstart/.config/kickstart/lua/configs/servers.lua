local methods = require 'configs.lspconfig'

local on_attach = methods.on_attach
local on_init = methods.on_init
local capabilities = methods.capabilities

local servers = {
  -- 'html',
  -- 'cssls',
  -- "clangd",
  'graphql',
  -- 'biome',
  'eslint',
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
  -- not sure if needed yet
  root_dir = require('lspconfig.util').root_pattern('yarn.lock', 'pnpm-lock.yamml', 'tsconfig.json'),
  single_file_support = false,
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
