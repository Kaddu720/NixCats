require("lze").load({
	-- Ui Dependencies
	{ "plenary.nvim", dep_of = { "none-ls.nvim" } },
	{ "nvim-web-devicons", dep_of = { "fzf-lua" } },

	-- UI elements with lazy loading
	{ import = "plugins.statusline" },
	{ import = "plugins.snacks-nvim" },

	-- Completion and LSP (load when needed)
	{ import = "plugins.blink-cmp" },
	{ import = "plugins.none-ls" },

	-- Syntax and parsing
	{ import = "plugins.treesitter" },

	-- File navigation and management (load on command or key)
	{ import = "plugins.oil" },
	{ import = "plugins.fzf-lua" },
	{ import = "plugins.flash" },
	{ import = "plugins.nvim-hlslens" },
	{ import = "plugins.comfy-line-numbers" },

	-- Git integration
	{ import = "plugins.gitblame" },

	-- Editing enhancements
	{ import = "plugins.nvim-autopairs" },
	{ import = "plugins.otter" },

  -- Obsidian
	{ import = "plugins.obsidian" },
	{ import = "plugins.rose-pine" },
	{ import = "plugins.ltex_extra" },

	-- Window management
	{ import = "plugins.tmux-navigator" },

	-- Diagnostics and help
	{ import = "plugins.trouble" },
	{ import = "plugins.which-key" },

	-- -- Environmental Variables
	{ import = "plugins.ecolog" },
})
