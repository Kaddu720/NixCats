-- Language Specific settings

-- Global LSP settings for better Claude Code performance
vim.lsp.config("*", {
	flags = {
		debounce_text_changes = 500,
	},
})

-- Defer LSP enabling to after startup (single consolidated call)
vim.defer_fn(function()
	vim.lsp.enable({
		"luals",      -- lua
		"pyright",    -- python
		"ruff",       -- python
		"nil_ls",     -- nix
		"ltex_plus",  -- markdown
		"bashls",     -- bash
		"yamlls",     -- yaml
		"terraformls",-- terraform
		"dockerls",   -- docker
		"helm_ls",    -- helm
		"nushell",    -- nushell
	})

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
