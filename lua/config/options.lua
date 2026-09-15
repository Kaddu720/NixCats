vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.inccommand = "split"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 10
vim.opt.conceallevel = 2
vim.cmd("syntax enable")
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.diagnostic.config({ virtual_lines = false, update_in_insert = false, float = { border = "rounded" } })
pcall(function()
	vim.opt.winborder = "rounded"
end)

vim.opt.history = 100
vim.opt.synmaxcol = 120
vim.opt.redrawtime = 1500
vim.opt.swapfile = false -- Intentional: this configuration does not use swap files.
vim.opt.updatetime = 500
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10
vim.opt.undolevels = 1000
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- herdr-nvim-nav owns Ctrl-h/j/k/l and delegates tmux edges to these commands.
vim.g.tmux_navigator_no_mappings = 1

vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	pattern = "*",
	callback = function()
		vim.api.nvim_echo({ { "File changed on disk. Buffer reloaded.", "WarningMsg" } }, false, {})
	end,
})
