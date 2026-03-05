return {
	{
		"fzf-lua",
		dep_of = { "obsidian" },
		keys = require("config.keymaps_registry").lazy_keys.fzf_lua,
		after = function()
			local registry = require("config.keymaps_registry")
			require("fzf-lua").setup({
				winopts = {
					border = "rounded",
					preview = {
						delay = 100,
						border = "rounded",
						layout = "horizontal",
						horizontal = "right:60%",
					},
					backdrop = 100,
				},
				fzf_opts = {
					["--layout"] = "reverse",
					["--prompt"] = ">  ",
				},
				fzf_colors = {
					["bg"] = { "bg", "Normal" },
					["bg+"] = { "bg", "Normal" },
					["gutter"] = { "bg", "Normal" },
					["border"] = "#e0def4",
					["label"] = "#e0def4",
					["pointer"] = "#f7768e",
				},
			})
			require("fzf-lua").register_ui_select()
			registry.fzf_lua()
		end,
	},
}
