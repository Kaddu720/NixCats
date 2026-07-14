return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	after = function()
		local theme = require("lualine.themes.auto")
		for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command" }) do
			theme[mode].a.bg, theme[mode].a.fg, theme[mode].c.bg = "#191724", "#b4637a", "#191724"
		end
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
				refresh = { statusline = 500, tabline = 1000, winbar = 500 },
			},
			sections = {
				lualine_a = { "branch" },
				lualine_b = {},
				lualine_c = { "%f" },
				lualine_x = {
					{ "diagnostics", sources = { "nvim_diagnostic" } },
					{
						function()
							return vim.ui.progress_status and vim.ui.progress_status() or ""
						end,
						cond = function()
							return vim.ui.progress_status and vim.ui.progress_status() ~= ""
						end,
					},
					{ "filetype", colored = false },
					"encoding",
					"fileformat",
					"progress",
					"location",
				},
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
		})
	end,
}
