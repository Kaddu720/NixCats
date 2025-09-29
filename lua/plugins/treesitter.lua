return {
	"nvim-treesitter",
	event = "DeferredUIEnter",
	after = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = { enable = true },
		})
	end,
}
