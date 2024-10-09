require("nvchad.mappings")
-- disable mappings
local nomap = vim.keymap.del

nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap("n", "<C-s>")
nomap("n", "<tab>")
nomap("n", "<S-tab>")
nomap("n", "<leader>ds")
nomap("n", "<leader>cc")

-- my keymappings
local map = vim.keymap.set

map("n", "<leader>tt", function()
	require("base46").toggle_transparency()
end, { desc = "Toggle transparency" })

map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", { desc = "Telescope Find files" })

map("n", "<leader>fm", function()
	require("conform").format()
end, { desc = "File Format with conform" })

map("n", "<space>g", ":Git <CR>")
map("n", "<space>vd", ":Gvdiff <CR>")
map("n", "<leader>ss", ":Gitsigns stage_hunk<CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")

-- staying in the middle
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- clipboard separation
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- deletion separation
map({ "n", "v" }, "<leader>d", [["_d]])
-- insert new line without leaving normal mode
map("n", "<leader>o", "o<Esc>")
map("n", "<leader>O", "O<Esc>")

-- spectre keymaps
map("n", "<leader>S", '<cmd>lua require("spectre").open()<CR>', {
	desc = "Open Spectre",
})
map("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
map("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
map("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

map("n", "<C-p>", "<C-i>")

-- GRAPPLE
map("n", "<leader>h", require("grapple").toggle)
map("n", "<leader>H", require("grapple").toggle_tags)
map("n", "<leader>1", "<cmd>Grapple select index=1<CR>")
map("n", "<leader>2", "<cmd>Grapple select index=2<CR>")
map("n", "<leader>3", "<cmd>Grapple select index=3<CR>")
map("n", "<leader>4", "<cmd>Grapple select index=4<CR>")
map("n", "<tab>", "<cmd>Grapple cycle_tags next scope=cwd<CR>")
map("n", "<S-tab>", "<cmd>Grapple cycle_tags previous scope=cwd<CR>")

-- LSP mappings
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "LSP floating diagnostics" })
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
-- map("n", "[d", vim.diagnostic.goto_prev, { desc = "Lsp prev diagnostic" })
-- map("n", "]d", vim.diagnostic.goto_next, { desc = "Lsp next diagnostic" })

-- bufjump
map("n", "<C-o>", ":lua require('bufjump').backward()<cr>")
map("n", "<C-p>", ":lua require('bufjump').forward()<cr>")

-- jumplist
-- map("n", "<C-o>", "<C-o>")
-- map("n", "<C-p>", "<C-i>")

-- quickfix list mappings
map("n", "<A-]>", "<CMD>cnext<CR>", { desc = "Quickfix List Next" })
map("n", "<A-[>", "<CMD>cprev<CR>", { desc = "Quickfix List Prev" })

map("n", "<leader>lr", "<CMD>LspRestart<CR>", { desc = "LSP Restart" })

-- obsidian mappings
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Obsidian: Create a new note" })
vim.keymap.set(
	"n",
	"<leader>ot",
	"<cmd>ObsidianTemplate<CR>",
	{ desc = "Obsidian: Insert a template into the nose using telescope.nvim" }
)
vim.keymap.set(
	"n",
	"<leader>of",
	"<cmd>ObsidianFollowLink<CR>",
	{ desc = "Obsidian: Follow a note reference under the cursor" }
)
