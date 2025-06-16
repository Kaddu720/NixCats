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
vim.g.loaded_netrw = 1-- Disable default Netrw if you use another file explorer
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchparen = 1-- Disable MatchParen if you use a Treesitter-based highlighter
vim.g.loaded_matchit = 1

-- Add LSP timeout to prevent hanging
vim.lsp.buf.request_sync = function(method, params, timeout_ms, client_id)
	local clients = vim.lsp.get_active_clients({ id = client_id })
	if #clients == 0 then
		return {}
	end

	timeout_ms = timeout_ms or 1000
	return vim.lsp.buf_request_sync(0, method, params, timeout_ms)
end

