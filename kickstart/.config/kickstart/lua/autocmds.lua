-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`
-- normal autocommands events (`:help autocmd-events`).

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

-- Force filetype detection on buffer enter
-- This ensures the first buffer opened gets its filetype detected properly
autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("ForceFiletypeDetection", { clear = true }),
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
    local filename = vim.api.nvim_buf_get_name(args.buf)

    -- Only for normal file buffers that don't have a filetype yet
    if buftype == "" and filetype == "" and filename ~= "" then
      vim.schedule(function()
        -- Force filetype detection
        vim.cmd("filetype detect")
      end)
    end
  end,
})
