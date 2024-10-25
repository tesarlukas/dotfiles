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
  -- "rust_analyzer",
}

local lspconfig = require 'lspconfig'

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require('typescript-tools').setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { 'tv\\((([^()]*|\\([^()]*\\))*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
        },
      },
    },
  },
}

lspconfig.emmet_ls.setup {
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
}

capabilities.textDocument.completion.completionItem.snippetSupport = true
