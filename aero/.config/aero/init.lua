vim.g.mapleader = ' '

require 'options'
require 'mappings'
require 'sessions'
require 'plugins' -- where external stuff starts
require 'tools' -- important to load tools right here because of the deps later
require 'lsp'
require 'format'
require 'treesitter'
require 'finder'
require 'tree'
require 'navigation'
require 'theme'
require 'statusline'
require 'git'
require 'completion'
