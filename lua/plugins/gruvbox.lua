return {
	{ "ellisonleao/gruvbox.nvim", priority = 1000 , eager = true, config = true, opts = {
		undercurl = true,
		underline = true,
		bold = true,
		italic = {
			strings = true,
			operators = true,
			comments = true,
		},
		strikethrough = true,
		invert_selection = false,
		invert_signs = false,
		invert_tabline = false,
		invert_intend_guides = false,
		inverse = true, -- invert background for search, diffs, statuslines and errors
		contrast = "hard", -- can be "hard", "soft" or empty string
		palette_overrides = {},
		overrides = {},
		dim_inactive = false,
		transparent_mode = false,
	},
	config = function()
		-- load the colorscheme here
		vim.cmd([[colorscheme gruvbox]])
	end,
	} 
}
