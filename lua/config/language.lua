-- Language Specific settings

-- Global LSP settings for better Claude Code performance
vim.lsp.config("*", {
	flags = {
		debounce_text_changes = 500, -- high debounce for AI-assisted rapid edits
	},
})

-- LSP servers auto-discovered from lsp/*.lua
-- NOTE: server binaries must be available via flake.nix lspsAndRuntimeDeps
local function list_lsp_servers()
	local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
	local files = vim.fn.glob(lsp_dir .. "/*.lua", false, true)
	table.sort(files)

	local servers = {}
	local disabled = {
		nil_ls = true, -- retained for rollback, but nixd owns Nix LSP for now
		pyright = true, -- retained for rollback, but ty owns Python LSP for now
	}
	for _, file in ipairs(files) do
		local name = vim.fn.fnamemodify(file, ":t:r")
		if not disabled[name] then
			table.insert(servers, name)
		end
	end
	return servers
end

-- Enable LSP servers immediately so the initial buffer can attach correctly
vim.lsp.enable(list_lsp_servers())

-- Filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "yaml",
	callback = function()
		vim.opt_local.cursorcolumn = true
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
	end,
})
