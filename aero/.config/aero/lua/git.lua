-- Tab walks every file, ]u / [u only the unreviewed ones
require('codediff').setup {
  keymaps = { view = { next_file = '<Tab>', prev_file = '<S-Tab>' } },
}

require('review').setup {
  keymaps = { next_file = ']u', prev_file = '[u' },
}

require('gitsigns').setup()

vim.keymap.set('n', '<leader>G', '<Cmd>Review<CR>', { desc = 'Review changes' })
vim.keymap.set('n', '<leader>g', '<Cmd>Git<CR>', { desc = 'Git status' })

-- override r key press
local reviewed = require 'review.reviewed'
local toggle_current = reviewed.toggle_current

reviewed.toggle_current = function(explorer)
  local skip = reviewed.skip_to_unreviewed
  reviewed.skip_to_unreviewed = function()
    return true, false
  end
  local ok, err = pcall(toggle_current, explorer)
  reviewed.skip_to_unreviewed = skip
  if not ok then
    error(err)
  end
  return false
end

local function toggle_reviewed_row()
  local explorer = require('codediff.ui.lifecycle').get_panel_view(vim.api.nvim_get_current_tabpage())
  local node = explorer and explorer.tree:get_node()
  if not node or not node.data or not node.data.path then
    return
  end
  local data = explorer.data
  local path, group = data.current_file_path, data.current_file_group
  data.current_file_path, data.current_file_group = node.data.path, node.data.group
  local ok, err = pcall(reviewed.toggle_current, explorer)
  data.current_file_path, data.current_file_group = path, group
  if not ok then
    error(err)
  end
end

local function stage_key(group)
  return function()
    local explorer = require('codediff.ui.lifecycle').get_panel_view(vim.api.nvim_get_current_tabpage())
    local node = explorer and explorer.tree:get_node()
    if node and node.data and node.data.group == group then
      require('codediff.ui.explorer').toggle_stage_entry(explorer, explorer.tree)
    end
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'codediff-explorer',
  callback = function(ev)
    vim.keymap.set('n', 's', stage_key 'unstaged', { buffer = ev.buf, desc = 'Stage' })
    vim.keymap.set('n', 'u', stage_key 'staged', { buffer = ev.buf, desc = 'Unstage' })
    vim.keymap.set('n', 'r', toggle_reviewed_row, { buffer = ev.buf, desc = 'Toggle file reviewed' })
  end,
})

-- jump to the next or previous reviewed file, from the panel or from the diff
local function reviewed_file(flags)
  return function()
    local explorer = require('codediff.ui.lifecycle').get_panel_view(vim.api.nvim_get_current_tabpage())
    if not explorer then
      return
    end
    vim.api.nvim_win_call(explorer.winid, function()
      vim.cmd.normal { flags == 'b' and '0' or '$', bang = true }
      if vim.fn.search('✓', flags) > 0 then
        vim.api.nvim_feedkeys(vim.keycode '<CR>', 'mx', false)
      end
    end)
  end
end

vim.keymap.set('n', ']r', reviewed_file '', { desc = 'Next reviewed file' })
vim.keymap.set('n', '[r', reviewed_file 'b', { desc = 'Previous reviewed file' })

vim.keymap.set('n', '<leader>vd', '<cmd>:CodeDiff file HEAD<CR>', { desc = 'View diff in file' })
