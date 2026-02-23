return {
	"nvim-hlslens",
	keys = {
		{ "/", mode = "n", desc = "Search in buffer" },
		{ "*", mode = "n", desc = "Search word under cursor (forward)" },
		{ "#", mode = "n", desc = "Search word under cursor (backward)" },
		{ "g*", mode = "n", desc = "Search partial word (forward)" },
		{ "g#", mode = "n", desc = "Search partial word (backward)" },
	},
	after = function()
		local registry = require("config.keymaps_registry")
		require("hlslens").setup()
		registry.hlslens()
	end,
}
