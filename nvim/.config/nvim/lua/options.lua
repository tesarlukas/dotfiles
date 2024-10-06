require("nvchad.options")

vim.opt.relativenumber = true
vim.opt.number = true

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.cmd("hi CurSearch guifg=#eeffff guibg=#82aaff")
