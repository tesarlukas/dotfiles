-- The statusline, built from small parts.
--
-- A part is a function that returns a piece of statusline text.
-- `%#Group#` switches the colour to a highlight group. The St_* groups are
-- made by base46 from the theme, so they change when the theme changes.
-- `%t`, `%l`, `%v` and friends are Neovim's own items, see `:help 'statusline'`.

local M = {}

-- the block that draws the coloured edge between two parts
local sep = '█'

-- the file part shows at most this many folders above the file
local levels_above = 2

-- a literal % in a path would be read as a statusline item
local function escape(text)
  return (text:gsub('%%', '%%%%'))
end

local function hl(group)
  return '%#' .. group .. '#'
end

-- first letter of Neovim's mode → the label to show and the St_<Name>Mode colours to use
local modes = {
  n = { 'NORMAL', 'Normal' },
  i = { 'INSERT', 'Insert' },
  v = { 'VISUAL', 'Visual' },
  V = { 'V-LINE', 'Visual' },
  ['\22'] = { 'V-BLOCK', 'Visual' },
  s = { 'SELECT', 'Select' },
  S = { 'S-LINE', 'Select' },
  R = { 'REPLACE', 'Replace' },
  c = { 'COMMAND', 'Command' },
  t = { 'TERMINAL', 'Terminal' },
  r = { 'CONFIRM', 'Confirm' },
}

local parts = {}

function parts.mode()
  local mode = modes[vim.api.nvim_get_mode().mode:sub(1, 1)] or modes.n
  local label, name = mode[1], mode[2]
  local edge = hl('St_' .. name .. 'ModeSep') .. sep .. hl 'St_EmptySpace' .. sep
  return hl('St_' .. name .. 'Mode') .. ' ' .. label .. ' ' .. edge
end

-- what to call windows that are tools, not files; the key is the window's filetype
local tool_names = {
  NvimTree = 'files',
  TelescopePrompt = 'telescope',
}

-- the file name with a few of the folders above it, never climbing above the working directory
function parts.file()
  local path = vim.api.nvim_buf_get_name(0)
  local shown, flags = '%t', ' %m' -- '%t' is Neovim's own name for the buffer, '%m' its modified flag
  if vim.bo.buftype ~= '' then
    -- not a file on disk: a tool window, a help page, a terminal
    shown, flags = tool_names[vim.bo.filetype] or '%t', ' '
  elseif path ~= '' then
    -- ':.' makes the path relative to the working directory when the file is inside it
    local pieces = vim.split(vim.fn.fnamemodify(path, ':.'), '/', { trimempty = true })
    shown = escape(table.concat(pieces, '/', math.max(1, #pieces - levels_above)))
  end
  return hl 'St_file' .. ' ' .. shown .. flags .. hl 'St_file_sep' .. sep
end

-- branch and change counts; the numbers come from gitsigns, so this stays empty without it
function parts.git()
  local status = vim.b.gitsigns_status_dict
  if not status or not status.head or status.head == '' then
    return ''
  end

  local text = ' ' .. status.head
  for _, change in ipairs { { 'added', '+' }, { 'changed', '~' }, { 'removed', '-' } } do
    local count = status[change[1]]
    if count and count > 0 then
      text = text .. ' ' .. change[2] .. count
    end
  end
  return hl 'St_gitIcons' .. text .. ' '
end

-- error, warning, hint and info counts for this file, each only when it is not zero
function parts.diagnostics()
  local counts = vim.diagnostic.count(0)
  local severity = vim.diagnostic.severity
  local text = ''
  for _, kind in ipairs {
    { severity.ERROR, 'E', 'St_lspError' },
    { severity.WARN, 'W', 'St_lspWarning' },
    { severity.HINT, 'H', 'St_LspHints' },
    { severity.INFO, 'I', 'St_LspInfo' },
  } do
    local count = counts[kind[1]]
    if count and count > 0 then
      text = text .. hl(kind[3]) .. kind[2] .. count .. ' '
    end
  end
  return text
end

-- the name of the working directory
function parts.dir()
  local path = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
  local name = path:match '([^/]+)/*$' or path
  return hl 'St_cwd_sep' .. sep .. hl 'St_cwd_text' .. ' ' .. escape(name) .. ' '
end

function parts.position()
  return hl 'St_pos_sep' .. sep .. hl 'St_pos_text' .. ' %l:%v '
end

-- what is shown, left to right; '%=' pushes everything after it to the right edge
local layout = { 'mode', 'file', 'git', '%=', 'diagnostics', 'dir', 'position' }

function M.render()
  local out = {}
  for _, name in ipairs(layout) do
    out[#out + 1] = parts[name] and parts[name]() or name
  end
  return table.concat(out)
end

vim.o.statusline = "%!v:lua.require'statusline'.render()"

-- redraw the bar as soon as the diagnostics change, not only on the next keypress
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function()
    vim.cmd.redrawstatus()
  end,
})

return M
