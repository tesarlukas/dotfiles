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
  filetypes = { 'javascriptreact', 'typescriptreact', 'javascript', 'typescript', 'graphql' },
}

lspconfig.tailwindcss.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'javascriptreact', 'typescriptreact', 'javascript', 'typescript', 'graphql' },
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

lspconfig.julials.setup {
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
        type = true, -- This might be key
        signature = true, -- And this
      },
      format = {
        indent = 4,
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
