local M = {}

function M.setup()
  local HEIGHT_RATIO = 0.8 -- You can change this
  local WIDTH_RATIO = 0.5 -- You can change this too

  require('nvim-tree').setup {
    git = { enable = false },
    filters = { dotfiles = false },
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    view = {
      width = 30,
      preserve_window_proportions = true,
      number = true,
      relativenumber = true,
      adaptive_size = false,
      float = {
        enable = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

          return {
            border = 'rounded',
            relative = 'editor',
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
    },
    renderer = {
      root_folder_label = ':~:s?$?/..?',
      highlight_git = true,
      indent_markers = { enable = true },
      icons = {
        glyphs = {
          default = '󰈚',
          folder = {
            default = '',
            empty = '',
            empty_open = '',
            open = '',
            symlink = '',
          },
          git = { unmerged = '' },
        },
      },
    },
  }
end

return M
