return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	after = function()
		-- custom lualine theme
		local custom_auto = require("lualine.themes.auto")
		custom_auto.normal.a.bg = "#191724"
		custom_auto.normal.a.fg = "#eb6f92"
		custom_auto.normal.c.bg = "#191724"

		custom_auto.insert.a.bg = "#191724"
		custom_auto.insert.a.fg = "#eb6f92"
		custom_auto.insert.c.bg = "#191724"

		custom_auto.visual.a.bg = "#191724"
		custom_auto.visual.a.fg = "#eb6f92"
		custom_auto.visual.c.bg = "#191724"

		custom_auto.replace.a.bg = "#191724"
		custom_auto.replace.a.fg = "#eb6f92"
		custom_auto.replace.c.bg = "#191724"

		custom_auto.command.a.bg = "#191724"
		custom_auto.command.a.fg = "#eb6f92"
		custom_auto.command.c.bg = "#191724"

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = custom_auto,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = true,
				refresh = {
					statusline = 250,
					tabline = 500,
					winbar = 250,
				},
			},
			sections = {
				lualine_a = { "branch" },
				lualine_b = {},
				lualine_c = { "%f" },
				lualine_x = { { "filetype", colored = false }, "encoding", "fileformat", "progress", "location" },
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
