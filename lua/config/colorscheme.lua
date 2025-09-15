-- Colorscheme
-- Enable true color support
vim.opt.termguicolors = true
-- Set colorscheme
vim.cmd("colorscheme quiet")

-- Set background
vim.cmd([[highlight Normal guibg=#191724 ctermbg=233]])

-- Set highlight groups
vim.api.nvim_set_hl(0, "Normal", { fg = "#e0def4" })

vim.api.nvim_set_hl(0, "Keyword", { bold = true, fg = "#e0def4" })
vim.api.nvim_set_hl(0, "Constant", { fg = "#908caa" })
vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "#eb6f92" })

-- Floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#e0def4", bg = "#191724" })
vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = "#e0def4", bg = "#191724" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#191724", fg = "#6e6a86" })

-- Splits
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#191724", fg = "#6e6a86", bold = true })

-- Cursor line - only highlight line number, keep background transparent
vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e0def4", bg = "NONE", bold = true })
