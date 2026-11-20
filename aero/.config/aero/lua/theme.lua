vim.g.base46_cache = vim.fn.stdpath 'data' .. '/base46_cache/'

if not vim.uv.fs_stat(vim.g.base46_cache) then
  require('base46').load_all_highlights()
end

--base46 compiles the theme into cache files once, and every start just loads them. The first block builds the cache when it doesn't exist yet; the loop applies it.
for _, file in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. file)
end

vim.api.nvim_create_user_command('ThemeCompile', function()
  require('base46').load_all_highlights()
end, { desc = 'Recompile the theme after changing nvconfig.lua' })
