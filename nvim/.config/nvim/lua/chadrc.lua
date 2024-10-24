local M = {}

M.ui = {
	tabufline = {
		enabled = false,
	},
	cmp = {
		format_colors = {
			tailwind = true,
			icon = "󱓻",
		},
	},
	telescope = { style = "bordered" }, -- borderless / bordered
}

M.base46 = {
	theme = "material-darker",
	transparency = false,
	changed_themes = {
		rosepine = {
			base_16 = {
				base0F = "#9b5b42",
			},
		},
		["material-darker"] = {
			base_30 = {
				darker_black = "#212121",
			},
		},
	},
	hl_override = {
		-- NvimTreeCursorLine = { bg = "black2" },

		-- mix colors, mixes black/blue from your theme by 10%
	},
}

return M
