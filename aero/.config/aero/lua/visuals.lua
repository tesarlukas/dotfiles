-- TODO, FIXME, NOTE and friends are highlighted in comments
require('todo-comments').setup { signs = false }

-- indent guides; the colours come from the theme (IblIndent, IblScope)
local hooks = require 'ibl.hooks'
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

require('ibl').setup {
  indent = { char = '│' },
  scope = { char = '│' },
}

-- colour previews: #ff0000, rgb() and hsl() get their colour as background
require('colorizer').setup()
