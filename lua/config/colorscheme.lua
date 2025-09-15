-- Colorscheme
vim.opt.termguicolors = true
vim.cmd("colorscheme quiet")

-- Color palette for consistency and performance
local colors = {
  bg = "#191724",
  fg = "#e0def4",
  gray = "#908caa", 
  border = "#6e6a86",
  red = "#eb6f92"
}

-- Helper function for performance
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Core highlights (consolidated and organized)
hl("Normal", { fg = colors.fg, bg = colors.bg })
hl("Keyword", { fg = colors.fg, bold = true })
hl("Constant", { fg = colors.gray })
hl("Comment", { fg = colors.red, italic = true })

-- Floating windows
hl("NormalFloat", { fg = colors.fg, bg = colors.bg })
hl("BlinkCmpKind", { fg = colors.fg, bg = colors.bg })
hl("FloatBorder", { fg = colors.border, bg = colors.bg })

-- Interface elements
hl("WinSeparator", { fg = colors.border, bg = colors.bg, bold = true })
hl("CursorLine", { bg = "#26233a" }) -- Rose-pine overlay color
hl("CursorLineNr", { fg = colors.fg, bg = "NONE", bold = true })
