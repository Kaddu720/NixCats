vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Colorscheme
-- Enable true color support
vim.opt.termguicolors = true
-- Set colorscheme
vim.cmd("colorscheme quiet")

-- Set background
vim.cmd([[highlight Normal guibg=#191724 ctermbg=233]])

-- Set highlight groups
vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "#eb6f92" })

vim.api.nvim_set_hl(0, "Normal", { italic = true, fg = "#e0def4" })

vim.api.nvim_set_hl(0, "Constant", { fg = "#908caa" })
vim.api.nvim_set_hl(0, "Keyword", { bold = true, fg = "#908caa" })
vim.api.nvim_set_hl(0, "Operator", { fg = "#908caa" })

-- Floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#191724" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#191724", fg = "#6e6a86" })


-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Indent
vim.o.expandtab = true -- convert tabs to spaces
vim.o.tabstop = 2 -- tab shifts 2 spaces
vim.o.softtabstop = 2
vim.o.shiftwidth = 2 -- make shift in vidual mode worth 2 spaces
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- Searching
vim.opt.hlsearch = true -- highlight search results
vim.opt.incsearch = true -- highlight objects as you search for them
vim.o.ignorecase = true -- ignore case when Searching
vim.o.smartcase = true -- case matters if I use capital letters
vim.opt.inccommand = "split" -- give an preview of commands before they are executed

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Appearence
vim.opt.scrolloff = 10 -- minum number of lines abobve/bellow cursor
-- vim.opt.showmode = false -- let lualine provide status
vim.opt.conceallevel = 2 -- let obsidan conceal test with ui

-- Diagnostics
vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})

-- Performance options
vim.opt.lazyredraw = true -- don't redraw screen during macros
vim.opt.hidden = true -- allow switching buffers without saving
vim.g.startup_time_enabled = true -- enable startup time measurement
vim.opt.history = 100 -- limit command history
vim.opt.synmaxcol = 240 -- don't syntax highlight long lines
vim.opt.redrawtime = 1500 -- time limit for syntax highlighting
vim.opt.ttyfast = true -- faster terminal rendering
vim.opt.swapfile = false -- don't use swapfiles
vim.opt.updatetime = 100 -- faster update time for better UX
vim.opt.timeout = true
vim.opt.timeoutlen = 300 -- faster timeout for keymaps
vim.opt.ttimeoutlen = 10 -- faster timeout for terminal keys

-- Configure Oil.nvim as default file manager
require("oil").setup({
	default_file_explorer = true,
	view_options = {
		show_hidden = true,
	},
	float = {
		-- Other float settings...

		-- Set winblend to 0 to avoid any background color issues
		winblend = 0,

		-- Directly set win_options
		win_options = {
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
		},
	},
})
vim.keymap.set("n", "-", "<Cmd>Oil --float<CR>", {})

-- Add LSP timeout to prevent hanging
vim.lsp.buf.request_sync = function(method, params, timeout_ms, client_id)
	local clients = vim.lsp.get_active_clients({ id = client_id })
	if #clients == 0 then
		return {}
	end

	timeout_ms = timeout_ms or 1000
	return vim.lsp.buf_request_sync(0, method, params, timeout_ms)
end

-- Language Specific settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "yaml",
	callback = function()
		vim.opt_local.cursorcolumn = true -- Highlight the current column
		vim.opt_local.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
		vim.opt_local.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
		vim.opt_local.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
		vim.opt_local.expandtab = true -- Expand tab to 2 spaces
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
		vim.opt_local.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations
		vim.opt_local.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
		vim.opt_local.expandtab = true -- Expand tab to 2 spaces
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
		vim.opt_local.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
		vim.opt_local.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
		vim.opt_local.expandtab = true -- Expand tab to 2 spaces
	end,
})
