-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local registry = require("config.keymaps_registry")

registry.core()

-- LSP keymaps (buffer-local)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		registry.lsp(args.buf)
	end,
})
