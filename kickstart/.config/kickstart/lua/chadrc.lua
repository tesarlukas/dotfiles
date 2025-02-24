local options = {

  base46 = {
    theme = 'everforest',
    transparency = true,
    changed_themes = {
      rosepine = {
        base_16 = {
          base0F = '#9b5b42',
        },
      },
      ['material-darker'] = {
        base_30 = {
          darker_black = '#212121',
        },
      },
      ['decay'] = {
        base_30 = {
          darker_black = '#171B20',
        },
      },
      ['everforest'] = {
        base_30 = {
          darker_black = '#2b3339',
        },
      },
    },
    hl_override = {
      NvimTreeCursorLine = { bg = 'black2' },

      -- mix colors, mixes black/blue from your theme by 10%
    },
  },

  ui = {
    cmp = {
      icons_left = false, -- only for non-atom styles!
      lspkind_text = true,
      style = 'default', -- default/flat_light/flat_dark/atom/atom_colored
      format_colors = {
        tailwind = false, -- will work for css lsp too
        -- icon = '󱓻',
        icon = '',
      },
    },

    telescope = { style = 'bordered' }, -- borderless / bordered

    statusline = {
      enabled = true,
      theme = 'default', -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      separator_style = 'block',
      order = nil,
      modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = false,
    },
  },

  nvdash = {
    enabled = false,
  },

  term = {
    enabled = false,
  },

  lsp = { signature = true },

  cheatsheet = {
    theme = 'grid', -- simple/grid
    excluded_groups = { 'terminal (t)', 'autopairs', 'Nvim', 'Opens' }, -- can add group name or with mode
  },

  mason = { pkgs = {} },

  colorify = {
    enabled = false,
    mode = 'virtual', -- fg, bg, virtual
    virt_text = '󱓻 ',
    highlight = { hex = true, lspvars = true },
  },
}

local status, chadrc = pcall(require, 'chadrc')
return vim.tbl_deep_extend('force', options, status and chadrc or {})
