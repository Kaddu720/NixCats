return {
	{
		"obsidian",
		cmd = { "Obsidian" },
		keys = require("config.keymaps_registry").lazy_keys.obsidian,
		after = function()
			local registry = require("config.keymaps_registry")
			local personal = vim.fn.hostname() == "Home-Box" or vim.fn.hostname() == "Mobile-Box"
			local vault = personal and "Second_Brain" or "Work_Brain"
			require("obsidian").setup({
				workspaces = {
					{
						name = vault,
						path = "~/Vaults/" .. vault,
						overrides = {
							daily_notes = { template = "~/Vaults/" .. vault .. "/resources/templates/neovim/daily.md" },
						},
					},
				},
				notes_subdir = "resources/notes",
				legacy_commands = false,
				picker = { name = "fzf-lua" },
				templates = { folder = "resources/templates/neovim" },
				daily_notes = {
					folder = "./logs/daily/",
					date_format = "%Y-%m-%d",
					alias_format = "%B %-d, %Y",
					default_tags = { "daily-notes" },
				},
				new_notes_location = "notes_subdir",
			})
			registry.obsidian()
		end,
	},
}
