local M = {}

-- every theme base46 ships, by name
local function theme_names()
  local dir = vim.api.nvim_get_runtime_file('lua/base46/themes', false)[1]
  local names = {}
  for _, file in ipairs(vim.fn.readdir(dir)) do
    names[#names + 1] = vim.fn.fnamemodify(file, ':r')
  end
  return names
end

-- switch the running editor to a theme
local function apply(name)
  require('nvconfig').base46.theme = name
  require('base46').load_all_highlights()
end

-- write the choice into nvconfig.lua, so it is still there after a restart
local function save(name)
  local path = vim.fn.stdpath 'config' .. '/lua/nvconfig.lua'
  local lines = vim.fn.readfile(path)
  for i, line in ipairs(lines) do
    if line:match '^%s*theme = [\'"]' then
      lines[i] = line:gsub('theme = [\'"][^\'"]*[\'"]', "theme = '" .. name .. "'")
      vim.fn.writefile(lines, path)
      return
    end
  end
  vim.notify('Theme not saved: no theme line found in ' .. path, vim.log.levels.WARN)
end

function M.pick_theme()
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local names = theme_names()
  local original = require('nvconfig').base46.theme
  local shown = original
  local confirmed = false

  local options = require('telescope.themes').get_dropdown {
    default_selection_index = vim.fn.index(names, original) + 1, -- start on the current theme
  }

  local picker = require('telescope.pickers').new(options, {
    prompt_title = 'Theme',
    finder = require('telescope.finders').new_table { results = names },
    sorter = require('telescope.config').values.generic_sorter {},
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        if not entry then
          return
        end
        confirmed = true
        actions.close(prompt_bufnr)
        apply(entry.value)
        save(entry.value)
      end)
      return true
    end,
  })

  -- preview: whenever the selection moves, show that theme
  local set_selection = picker.set_selection

  picker.set_selection = function(self, row)
    set_selection(self, row)
    local entry = action_state.get_selected_entry()
    if entry and entry.value ~= shown then
      shown = entry.value
      apply(shown)
    end
  end

  -- closing without choosing puts the old theme back
  local close_windows = picker.close_windows

  picker.close_windows = function(status)
    close_windows(status)
    if not confirmed and shown ~= original then
      apply(original)
    end
  end

  picker:find()
end

return M
