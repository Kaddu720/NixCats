return {
	{
		"flash.nvim",
		keys = require("config.keymaps_registry").lazy_keys.flash,
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
