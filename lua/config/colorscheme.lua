vim.opt.termguicolors = true
vim.cmd.colorscheme("quiet")

local colors = {
	bg = "#191724",
	fg = "#e0def4",
	gray = "#908caa",
	border = "#6e6a86",
	red = "#b4637a",
	orange = "#bb5c3a",
	yellow = "#c78645",
	blue = "#3b83aa",
	purple = "#563ea9",
	light_gray = "#c7c4c4",
}
local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

local function set_shared_highlights()
	hl("Normal", { fg = colors.fg, bg = colors.bg })
	hl("NormalFloat", { fg = colors.fg, bg = colors.bg })
	hl("BlinkCmpKind", { fg = colors.fg, bg = colors.bg })
	hl("FloatBorder", { fg = colors.border, bg = colors.bg })
	hl("WinSeparator", { fg = colors.border, bg = colors.bg, bold = true })
	hl("CursorLine", { bg = "#26233a" })
	hl("CursorLineNr", { fg = colors.fg, bg = "NONE", bold = true })
end

local function set_code_theme()
	set_shared_highlights()
	hl("Keyword", { fg = colors.fg, bold = true })
	hl("Constant", { fg = colors.gray })
	hl("Comment", { fg = colors.red, italic = true })
	hl("String", { fg = colors.fg })
	hl("Function", { fg = colors.fg })
	hl("Type", { fg = colors.fg })
	hl("Identifier", { fg = colors.fg })
	hl("Statement", { fg = colors.fg, bold = true })
	hl("PreProc", { fg = colors.fg })
	hl("Special", { fg = colors.fg })
	hl("Operator", { fg = colors.fg })
end

local function set_markdown_theme()
	set_shared_highlights()
	hl("Keyword", { fg = colors.purple, bold = true })
	hl("Constant", { fg = colors.orange })
	hl("Comment", { fg = colors.red, italic = true })
	hl("String", { fg = colors.yellow })
	hl("Function", { fg = colors.blue })
	hl("Type", { fg = colors.blue })
	hl("Identifier", { fg = colors.fg })
	hl("Statement", { fg = colors.purple, bold = true })
	hl("PreProc", { fg = colors.red })
	hl("Special", { fg = colors.orange })
	hl("Operator", { fg = colors.fg })
	hl("@markup.heading.1.markdown", { fg = colors.light_gray, bold = true })
	hl("@markup.heading.2.markdown", { fg = colors.blue, bold = true })
	hl("@markup.heading.3.markdown", { fg = colors.orange, bold = true })
	hl("@markup.heading.4.markdown", { fg = colors.yellow, bold = true })
	hl("@markup.heading.5.markdown", { fg = colors.red, bold = true })
	hl("@markup.heading.6.markdown", { fg = colors.purple, bold = true })
end

local current_theme
local function update_theme(args)
	local theme = vim.bo[args.buf].filetype == "markdown" and "markdown" or "code"
	if theme == current_theme then
		return
	end
	current_theme = theme
	if theme == "markdown" then
		set_markdown_theme()
	else
		set_code_theme()
	end
end

-- ponytail: highlights are global, so the active window controls the palette;
-- use highlight namespaces if simultaneous per-window themes are needed.
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, { callback = update_theme })
update_theme({ buf = vim.api.nvim_get_current_buf() })
