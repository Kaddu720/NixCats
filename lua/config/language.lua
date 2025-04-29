-- Language Specific settings
-- lua
vim.lsp.enable({ "luals" })

-- python
vim.lsp.enable({ "pyright", "ruff" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
		vim.opt_local.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations
		vim.opt_local.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
		vim.opt_local.expandtab = true -- Expand tab to 2 spaces
	end,
})

-- nix
vim.lsp.enable({ "nil_ls", "nixd" })

-- markdown
vim.lsp.enable({ "ltex_plus" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
		vim.opt_local.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
		vim.opt_local.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
		vim.opt_local.expandtab = true -- Expand tab to 2 spaces
	end,
})

-- bash
vim.lsp.enable({ "bashls" })

-- yaml
vim.lsp.enable({ "yamlls" })
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

-- terraform
vim.lsp.enable({ "terraformls" })
