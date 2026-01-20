return {
	{
		"reld-colorscheme",
		ft = "markdown",
		after = function()
			local colors = {
				bg = "#191724",
				fg = "#e0def4",
				cursor = "#c7c4c4",
				selection_bg = "#c7c4c4",
				selection_fg = "#191724",
				red = "#b4637a",
				orange = "#bb5c3a",
				yellow = "#c78645",
				blue = "#3b83aa",
				purple = "#563ea9",
				light_gray = "#c7c4c4",
				brown = "#aa7264",
			}

			local function hl(group, opts)
				vim.api.nvim_set_hl(0, group, opts)
			end

			hl("Normal", { fg = colors.fg, bg = colors.bg })
			hl("Keyword", { fg = colors.purple, bold = true })
			hl("Constant", { fg = colors.orange })
			hl("String", { fg = colors.yellow })
			hl("Function", { fg = colors.blue })
			hl("Type", { fg = colors.blue })
			hl("Comment", { fg = colors.brown, italic = true })
			hl("Identifier", { fg = colors.fg })
			hl("Statement", { fg = colors.purple, bold = true })
			hl("PreProc", { fg = colors.red })
			hl("Special", { fg = colors.orange })
			hl("Operator", { fg = colors.fg })
			hl("NormalFloat", { fg = colors.fg, bg = colors.bg })
			hl("FloatBorder", { fg = colors.brown, bg = colors.bg })
			hl("WinSeparator", { fg = colors.brown, bg = colors.bg, bold = true })
			hl("CursorLine", { bg = "#26233a" })
			hl("CursorLineNr", { fg = colors.cursor, bg = "NONE", bold = true })
			hl("Cursor", { fg = colors.bg, bg = colors.cursor })
			hl("Visual", { fg = colors.selection_fg, bg = colors.selection_bg })
			
			hl("@markup.heading.1.markdown", { fg = colors.light_gray, bold = true })
			hl("@markup.heading.2.markdown", { fg = colors.blue, bold = true })
			hl("@markup.heading.3.markdown", { fg = colors.orange, bold = true })
			hl("@markup.heading.4.markdown", { fg = colors.yellow, bold = true })
			hl("@markup.heading.5.markdown", { fg = colors.red, bold = true })
			hl("@markup.heading.6.markdown", { fg = colors.purple, bold = true })
		end,
	}
}
