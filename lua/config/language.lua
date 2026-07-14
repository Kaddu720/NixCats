vim.lsp.config("*", { flags = { debounce_text_changes = 500 } })
local function list_lsp_servers()
	local files = vim.fn.glob(vim.fn.stdpath("config") .. "/lsp/*.lua", false, true)
	table.sort(files)
	local servers = {}
	for _, file in ipairs(files) do
		local name = vim.fn.fnamemodify(file, ":t:r")
		if name ~= "ltex_plus" or vim.fn.executable("ltex-ls-plus") == 1 then
			table.insert(servers, name)
		end
	end
	return servers
end
vim.lsp.enable(list_lsp_servers())
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.shiftwidth, vim.opt_local.softtabstop, vim.opt_local.tabstop, vim.opt_local.expandtab =
			4, 4, 4, true
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "yaml" },
	callback = function()
		vim.opt_local.shiftwidth, vim.opt_local.softtabstop, vim.opt_local.tabstop, vim.opt_local.expandtab =
			2, 2, 2, true
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "yaml",
	callback = function()
		vim.opt_local.cursorcolumn = true
	end,
})
