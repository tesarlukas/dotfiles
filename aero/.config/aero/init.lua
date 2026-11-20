vim.g.mapleader = ' '

require 'options'
require 'mappings'
require 'sessions'
require 'plugins'
-- important to load tools right here because of the deps
require 'tools'
require 'lsp'
require 'format'
require 'treesitter'
require 'finder'
