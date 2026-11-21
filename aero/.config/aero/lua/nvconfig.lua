return {
  base46 = {
    theme = 'kanagawa-dragon',
    transparency = false,
    theme_toggle = { 'kanagawa-dragon', 'kanagawa-dragon' },
    integrations = {},
    hl_add = {},
    hl_override = {
      -- added lines in diffs: the theme's own green is a grey-olive that turns
      -- brown on this background, so this is a fixed dark green instead
      DiffAdd = { bg = '#25301f' },
    },
    changed_themes = {
      ['kanagawa-dragon'] = {
        base_30 = { black = '#251B17', darker_black = '#251B17' },
        base_16 = { base00 = '#251B17' },
      },
    },
  },
  ui = {
    cmp = { style = 'default' },
    telescope = { style = 'bordered' },
    statusline = { enabled = true, theme = 'default' },
  },
  cheatsheet = { theme = 'grid' },
}
