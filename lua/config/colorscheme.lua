vim.opt.termguicolors = true

local colors = {
	bg = "#191724",
	fg = "#e0def4",
	gray = "#908caa",
	border = "#6e6a86",
	red = "#b4637a",
	-- Reld colorful theme colors
	cursor = "#c7c4c4",
	selection_bg = "#c7c4c4",
	selection_fg = "#191724",
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

-- Shared highlight settings (used by both themes)
local function set_shared_highlights()
	hl("NormalFloat", { fg = colors.fg, bg = colors.bg })
	hl("BlinkCmpKind", { fg = colors.fg, bg = colors.bg })
	hl("FloatBorder", { fg = colors.border, bg = colors.bg })
	hl("WinSeparator", { fg = colors.border, bg = colors.bg, bold = true })
	hl("CursorLine", { bg = "#26233a" })
	hl("CursorLineNr", { fg = colors.fg, bg = "NONE", bold = true })
end

-- Mono colorscheme for code
local function set_mono_theme()
	vim.cmd("colorscheme quiet")
	hl("Normal", { fg = colors.fg, bg = colors.bg })
	hl("Keyword", { fg = colors.fg, bold = true })
	hl("Constant", { fg = colors.gray })
	hl("Comment", { fg = colors.red, italic = true })
	set_shared_highlights()
end

-- Reld colorful colorscheme for markdown
local function set_reld_theme()
	vim.cmd("colorscheme quiet")
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
	-- Markdown headings
	hl("@markup.heading.1.markdown", { fg = colors.light_gray, bold = true })
	hl("@markup.heading.2.markdown", { fg = colors.blue, bold = true })
	hl("@markup.heading.3.markdown", { fg = colors.orange, bold = true })
	hl("@markup.heading.4.markdown", { fg = colors.yellow, bold = true })
	hl("@markup.heading.5.markdown", { fg = colors.red, bold = true })
	hl("@markup.heading.6.markdown", { fg = colors.purple, bold = true })
end

-- Lualine theme refresh functions
local function refresh_lualine_mono()
	local ok, lualine = pcall(require, "lualine")
	if not ok then return end
	local theme = require("lualine.themes.auto")
	for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command" }) do
		theme[mode].a.bg = colors.bg
		theme[mode].a.fg = colors.red
		theme[mode].c.bg = colors.bg
	end
	lualine.setup({ options = { theme = theme } })
end

local function refresh_lualine_reld()
	local ok, lualine = pcall(require, "lualine")
	if not ok then return end
	local theme = require("lualine.themes.auto")
	for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command" }) do
		theme[mode].a.bg = colors.bg
		theme[mode].a.fg = colors.blue
		theme[mode].c.bg = colors.bg
	end
	lualine.setup({ options = { theme = theme } })
end

-- Track current theme to avoid unnecessary refreshes
local current_theme = nil

-- Set initial theme
set_mono_theme()
current_theme = "mono"

-- Switch to reld theme for markdown
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md", "*.markdown" },
	callback = function()
		if current_theme ~= "reld" then
			set_reld_theme()
			refresh_lualine_reld()
			current_theme = "reld"
		end
	end,
})

-- Switch back to mono theme for non-markdown files
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local ft = vim.bo.filetype
		local ext = vim.fn.expand("%:e")
		if ft ~= "markdown" and ext ~= "md" and ext ~= "markdown" then
			if current_theme ~= "mono" then
				set_mono_theme()
				refresh_lualine_mono()
				current_theme = "mono"
			end
		end
	end,
})
