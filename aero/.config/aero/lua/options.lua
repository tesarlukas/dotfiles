local o = vim.opt

-- synchronize clipboard between neovim and OS
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- highlight
o.cursorline = true
o.cursorlineopt = 'number'

o.number = true
o.relativenumber = true
o.numberwidth = 2

-- one statusline for the entire nvim window
o.laststatus = 3

-- mouse mode allow
o.mouse = 'a'

-- while searching
o.ignorecase = true
o.smartcase = true

o.showmode = false

o.breakindent = true

-- remembers history of the file even after the turn off
o.undofile = true

o.signcolumn = 'yes'

-- default is 4000, basically a ms of inactiveness after which neovim writes a
-- swap file for the file in the buffer
o.updatetime = 250

-- split orientation
o.splitright = true
o.splitbelow = true

-- tildas removal from sign column
o.fillchars:append { eob = ' ' }

-- block cursor in every mode
o.guicursor = 'n-v-c:block,i:block'

o.scrolloff = 10

-- indentation preferences
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.smartindent = true

-- just hide some of the annoying characters
o.list = true
o.listchars = { tab = '  ', trail = ' ', nbsp = '␣' }

-- no key press crosses to the next line
o.whichwrap = ''

o.linebreak = true

-- border of all the floating windows
o.winborder = 'rounded'

-- so that when screen splits, nothing gets shifted, it gets covered instead
o.splitkeep = 'screen'

-- selecting past what's actually on the line
o.virtualedit = 'block'

-- basically a small preview when making a string substitution
o.inccommand = 'split'
