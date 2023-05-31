local options = {
  ensure_installed = { "lua", "c", "rust", "javascript", "typescript", "ruby", "tsx"},

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },

  autotag = {
    enable = true,
    filetypes = {
      'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
      'css', 'lua', 'xml', 'php', 'markdown'
    },
  },
}

return options
