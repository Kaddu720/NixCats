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
	for _, file in ipairs(files) do
		local name = vim.fn.fnamemodify(file, ":t:r")
		if name ~= "nixd" then -- enabled separately; must start after nil_ls attaches
			table.insert(servers, name)
		end
	end
	return servers
end

-- Defer LSP enabling to after startup (single consolidated call)
vim.defer_fn(function()
	vim.lsp.enable(list_lsp_servers())

	-- Enable nixd after nil_ls attaches (only for nix files)
	local nixd_enabled = false
	vim.api.nvim_create_autocmd("LspAttach", {
		pattern = { "*.nix" },
		callback = function(args)
			if nixd_enabled then return end
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client.name == "nil_ls" then
				nixd_enabled = true
				vim.lsp.enable({ "nixd" })
			end
		end,
	})
end, 0)

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
