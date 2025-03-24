require("lze").load({
	-- Core plugins that should load immediately
	{ import = "plugins.rose-pine" },
	{ import = "plugins.plenary" },

	-- UI elements with lazy loading
	{ import = "plugins.lualine" },
	{ import = "plugins.snacks-nvim" },
	{ import = "plugins.noice" },

	-- Completion and LSP (load when needed)
	{ import = "plugins.blink-cmp" },
	{ import = "plugins.none-ls" },

	-- Syntax and parsing
	{ import = "plugins.treesitter" },

	-- File navigation and management (load on command or key)
	{ import = "plugins.fzf-lua"},
	{ import = "plugins.oil-nvim"},
	{ import = "plugins.avante"},
	{ import = "plugins.obsidian-nvim"},
	{ import = "plugins.harpoon"},

	-- Git integration
	{ import = "plugins.gitblame"},

	-- File explorer and navigation
	{ import = "plugins.neo-tree"},

	-- Editing enhancements
	{ import = "plugins.nvim-autopairs" },
	{ import = "plugins.otter"},

	-- Window management
	{ import = "plugins.tmux-navigator"},

	-- Diagnostics and help
	{ import = "plugins.trouble" },
	{ import = "plugins.which-key"},

	-- Theme and visuals
	{ import = "plugins.ecolog" },
})
