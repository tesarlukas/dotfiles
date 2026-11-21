-- :InsertToday puts today's date at the cursor, as "2026, November, 21, Saturday"
vim.api.nvim_create_user_command('InsertToday', function()
  local year = os.date '%Y'
  local month = os.date '%B'
  local day_num = tonumber(os.date '%d')
  local day_name = os.date '%A'
  local date = string.format('%s, %s, %d, %s', year, month, day_num, day_name)
  vim.api.nvim_put({ date }, 'c', true, true)
end, { desc = "Insert today's date" })

vim.keymap.set('n', '<leader>to', '<Cmd>InsertToday<CR>', { desc = 'Insert [T][o]day' })

-- :Lorem puts 20 random lorem ipsum words at the cursor, :Lorem 40 puts 40
local lorem_words = vim.split(
  [[lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut
labore et dolore magna aliqua enim ad minim veniam quis nostrud exercitation ullamco laboris
nisi aliquip ex ea commodo consequat duis aute irure in reprehenderit voluptate velit esse
cillum fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt culpa qui
officia deserunt mollit anim id est laborum]],
  '%s+'
)

vim.api.nvim_create_user_command('Lorem', function(opts)
  local count = tonumber(opts.args) or 20
  local words = {}
  for _ = 1, count do
    words[#words + 1] = lorem_words[math.random(#lorem_words)]
  end
  local text = table.concat(words, ' ')
  vim.api.nvim_put({ text:sub(1, 1):upper() .. text:sub(2) .. '.' }, 'c', true, true)
end, { nargs = '?', desc = 'Insert lorem ipsum words, 20 by default' })
