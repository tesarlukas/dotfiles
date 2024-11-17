-- [[ Setting options ]]
local o = vim.opt
local g = vim.g

-- See `:help o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
--
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
g.mapleader = ' '
g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
g.have_nerd_font = true
-- Turn on termguicolors
o.termguicolors = true

-- Highlight cursroline. Set the option to highlight the number only so that
-- the whole file is line is not highlighted.
o.cursorline = true
o.cursorlineopt = 'number'

-- Make line relative numbers
o.number = true
o.relativenumber = true
o.numberwidth = 2

-- Disable default statusline
o.laststatus = 3

-- Enable mouse mode, can be useful for resizing splits for example!
o.mouse = 'a'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

-- Don't show the mode, since it's already in the status line
o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Keep signcolumn on by default
o.signcolumn = 'yes'

-- Decrease update time
o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
o.timeoutlen = 300

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

--  Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
o.list = true
o.listchars = { tab = '  ', trail = ' ', nbsp = '␣' }

-- remove tildas
o.fillchars:append { eob = ' ' }

-- Preview substitutions live, as you type!
o.inccommand = 'nosplit'

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 10

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

-- Go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
o.whichwrap:append '<>[]hl'

-- vim.opt.guicursor = {
--   'n-v-c:block', -- Normal, visual, command modes: block cursor (no blink)
--   'i-ci-ve:block', -- Insert mode: blinking block (4Hz)
--   'r-cr:block', -- Replace mode: block cursor
--   'o:block', -- Operator pending mode: block cursor
-- }
