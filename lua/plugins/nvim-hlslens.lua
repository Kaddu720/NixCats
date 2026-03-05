return {
	"nvim-hlslens",
	keys = require("config.keymaps_registry").lazy_keys.hlslens,
	after = function()
		local registry = require("config.keymaps_registry")
		require("hlslens").setup()
		registry.hlslens()
	end,
}
