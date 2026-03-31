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

		local function current_lualine_mode()
			local mode = vim.api.nvim_get_mode().mode
			if mode:match("^[vV\22]") then return "visual" end
			if mode:match("^i") or mode:match("^ic") then return "insert" end
			if mode:match("^[Rr]") then return "replace" end
			if mode:match("^[c]") then return "command" end
			return "normal"
		end

		local function section_color(section)
			local function to_hex(color)
				if type(color) == "number" then
					return string.format("#%06x", color)
				end
				return color
			end

			local group = string.format("lualine_%s_%s", section, current_lualine_mode())
			local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
			if ok and hl then
				return {
					fg = to_hex(hl.fg),
					bg = to_hex(hl.bg),
				}
			end
			return { fg = nil, bg = "#191724" }
		end

		local function diagnostic_count(severity)
			return #vim.diagnostic.get(0, { severity = severity })
		end

		local function diagnostic_pair(letter, severity)
			return {
				{
					function() return letter .. ":" end,
					cond = function() return diagnostic_count(severity) > 0 end,
					color = function()
						local c = section_color("c")
						return { fg = "#b4637a", bg = c.bg }
					end,
					padding = { left = 1, right = 0 },
				},
				{
					function() return tostring(diagnostic_count(severity)) end,
					cond = function() return diagnostic_count(severity) > 0 end,
					color = function() return section_color("c") end,
					padding = { left = 0, right = 1 },
				},
			}
		end

		local lualine_x = {}
		for _, pair in ipairs({
			diagnostic_pair("E", vim.diagnostic.severity.ERROR),
			diagnostic_pair("W", vim.diagnostic.severity.WARN),
			diagnostic_pair("I", vim.diagnostic.severity.INFO),
			diagnostic_pair("H", vim.diagnostic.severity.HINT),
		}) do
			vim.list_extend(lualine_x, pair)
		end

		local function progress_status()
			if vim.ui and vim.ui.progress_status then
				return vim.ui.progress_status()
			end
			return ""
		end

		vim.list_extend(lualine_x, {
			{ progress_status, cond = function() return progress_status() ~= "" end },
			{ "filetype", colored = false },
			"encoding",
			"fileformat",
			"progress",
			"location",
		})

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
				lualine_x = lualine_x,
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
