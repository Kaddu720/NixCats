return {
	"nvim-treesitter",
	event = "BufReadPost",
	after = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
