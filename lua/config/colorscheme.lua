vim.opt.termguicolors = true
vim.cmd.colorscheme("quiet")

local colors = { bg = "#191724", fg = "#e0def4", gray = "#908caa", border = "#6e6a86", red = "#b4637a" }
local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = colors.fg, bg = colors.bg })
hl("NormalFloat", { fg = colors.fg, bg = colors.bg })
hl("BlinkCmpKind", { fg = colors.fg, bg = colors.bg })
hl("FloatBorder", { fg = colors.border, bg = colors.bg })
hl("WinSeparator", { fg = colors.border, bg = colors.bg, bold = true })
hl("CursorLine", { bg = "#26233a" })
hl("CursorLineNr", { fg = colors.fg, bg = "NONE", bold = true })
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
