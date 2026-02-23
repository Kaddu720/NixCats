return {
	{
		"flash.nvim",
		keys = {
			{ "S", mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
			{ "f", mode = { "n", "o", "x" } },
			{ "F", mode = { "n", "o", "x" } },
			{ "r", mode = "o", desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, desc = "Toggle Flash Search" },
		},
		after = function()
			local registry = require("config.keymaps_registry")
			require("flash").setup({
				modes = {
					search = {
						enabled = false,
					},
					char = {
						jump_labels = true,
					},
				},
			})
			registry.flash()
		end,
	},
}
