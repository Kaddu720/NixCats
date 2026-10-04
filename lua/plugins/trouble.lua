return {
	"trouble.nvim",
	keys = require("config.keymaps_registry").lazy_keys.trouble,
	after = function()
		require("config.keymaps_registry").trouble()
	end,
}
