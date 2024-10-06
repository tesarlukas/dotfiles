local options = {
	dir = "/media/oem/MoreStuff/ObsidianVault/MyVault",
	notes_subdir = "Zettelkasten",
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},
	new_notes_location = "notes_subdir",
	disable_frontmatter = true,
	templates = {
		subdir = "Templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M:%S",
	},
	mappings = {},
	ui = {
		enable = true,
	},

}

require("obsidian").setup(options)
