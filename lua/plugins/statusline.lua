return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	after = function()
		-- custom lualine theme
		local custom_auto = require("lualine.themes.auto")
		custom_auto.normal.a.bg = "#191724"
		custom_auto.normal.a.fg = "#b4637a"
		custom_auto.normal.c.bg = "#191724"

		custom_auto.insert.a.bg = "#191724"
		custom_auto.insert.a.fg = "#b4637a"
		custom_auto.insert.c.bg = "#191724"

		custom_auto.visual.a.bg = "#191724"
		custom_auto.visual.a.fg = "#b4637a"
		custom_auto.visual.c.bg = "#191724"

		custom_auto.replace.a.bg = "#191724"
		custom_auto.replace.a.fg = "#b4637a"
		custom_auto.replace.c.bg = "#191724"

		custom_auto.command.a.bg = "#191724"
		custom_auto.command.a.fg = "#b4637a"
		custom_auto.command.c.bg = "#191724"

		local function diag_status()
			if vim.diagnostic.status then
				return vim.diagnostic.status()
			end

			local levels = vim.diagnostic.severity
			local e = #vim.diagnostic.get(0, { severity = levels.ERROR })
			local w = #vim.diagnostic.get(0, { severity = levels.WARN })
			local i = #vim.diagnostic.get(0, { severity = levels.INFO })
			local h = #vim.diagnostic.get(0, { severity = levels.HINT })

			local parts = {}
			if e > 0 then table.insert(parts, "E:" .. e) end
			if w > 0 then table.insert(parts, "W:" .. w) end
			if i > 0 then table.insert(parts, "I:" .. i) end
			if h > 0 then table.insert(parts, "H:" .. h) end
			return table.concat(parts, " ")
		end

		local function progress_status()
			if vim.ui and vim.ui.progress_status then
				return vim.ui.progress_status()
			end
			return ""
		end

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
				lualine_x = {
					{ diag_status, cond = function() return diag_status() ~= "" end },
					{ progress_status, cond = function() return progress_status() ~= "" end },
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
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
