vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'telescope-fzf-native.nvim' and ev.data.kind ~= 'delete' then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-tree/nvim-tree.lua',
  'https://github.com/cbochs/grapple.nvim',
  'https://github.com/nvchad/base46',
  'https://github.com/esmuellert/codediff.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/georgeguimaraes/review.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/tpope/vim-fugitive',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/coder/claudecode.nvim'
}
