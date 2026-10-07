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
local function check_external_changes()
	local mode = vim.api.nvim_get_mode()
	if mode.mode == "n" and not mode.blocking and vim.fn.getcmdwintype() == "" then
		local checked = {}
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			local buf = vim.api.nvim_win_get_buf(win)
			if not checked[buf] then
				checked[buf] = true
				vim.cmd("checktime " .. buf)
			end
		end
	end
end
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	callback = check_external_changes,
})
-- Focus events alone miss agent edits while we stay in the same buffer.
vim.fn.timer_start(1000, check_external_changes, { ["repeat"] = -1 })
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	pattern = "*",
	callback = function()
		vim.api.nvim_echo({ { "File changed on disk. Buffer reloaded.", "WarningMsg" } }, false, {})
	end,
})
