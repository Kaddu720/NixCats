require("lze").load({
	-- Core plugins that should load immediately
	{ import = "plugins.rose-pine" },
	{ import = "plugins.plenary" },

	-- UI elements with lazy loading
	{ import = "plugins.statusline" },
	{ import = "plugins.snacks-nvim" },

	-- Completion and LSP (load when needed)
	{ import = "plugins.blink-cmp" },
	{ import = "plugins.none-ls" },

	-- Syntax and parsing
	{ import = "plugins.treesitter" },

	-- File navigation and management (load on command or key)
	{ import = "plugins.fzf-lua" },
	{ import = "plugins.oil-nvim" },
	{ import = "plugins.avante" },
	{ import = "plugins.obsidian-nvim" },

	-- Git integration
	{ import = "plugins.gitblame" },

	-- Editing enhancements
	{ import = "plugins.mini-nvim" },
	{ import = "plugins.otter" },

	-- Window management
	{ import = "plugins.tmux-navigator" },

	-- Diagnostics and help
	{ import = "plugins.trouble" },
	{ import = "plugins.which-key" },

	-- Environmental Variables
	{ import = "plugins.ecolog" },
})
