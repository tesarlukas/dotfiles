local opts = {
  lsp_fallback = true,
  default_format_opts = { stop_after_first = true },
  notify_on_error = false,
  -- format_on_save = function(bufnr)
  --   -- Disable "format_on_save lsp_fallback" for languages that don't
  --   -- have a well standardized coding style. You can add additional
  --   -- languages here or re-enable it for the disabled ones.
  --   local disable_filetypes = { c = true, cpp = true }
  --   local lsp_format_opt
  --   if disable_filetypes[vim.bo[bufnr].filetype] then
  --     lsp_format_opt = 'never'
  --   else
  --     lsp_format_opt = 'fallback'
  --   end
  --   return {
  --     timeout_ms = 500,
  --     lsp_format = lsp_format_opt,
  --   }
  -- end,
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { "prettierd", 'prettier' },
    typescript = { "prettierd", 'prettier' },
    typescriptreact = { 'prettierd', 'prettier' },
    javascriptreact = { 'prettierd', 'prettier' },
    json = { 'prettierd', 'prettier' },
    jsonc = { "prettierd", 'prettier' },
    yaml = { 'prettierd', "prettier", 'biome' },
    graphql = { 'prettierd', 'prettier' },
  },

  -- formatters_by_ft = {
  --   lua = { 'stylua' },
  --   javascript = { 'biome' },
  --   typescript = { 'biome' },
  --   typescriptreact = { 'biome' },
  --   javascriptreact = { 'biome' },
  --   json = { 'biome' },
  --   yaml = { 'biome' },
  --   graphql = { 'biome' },
  -- },
}

return opts
