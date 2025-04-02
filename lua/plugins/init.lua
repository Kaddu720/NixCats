require("lze").load({
	-- Ui Dependencies
	{ "dressing-nvim", dep_of = "avante.nvim" },
	{ "plenary.nvim", dep_of = { "avante.nvim", "obsidian.nvim", "none-ls.nvim" } },
	{ "nui.nvim", dep_of = "avante.nvim" },
	{ "nvim-web-devicons", dep_of = { "avante.nvim", "fzf-lua" } },

	-- UI elements with lazy loading
	{ import = "plugins.statusline" },
	{ import = "plugins.snacks-nvim" },
  { import = "plugins.nvim-hlslens" },

	-- Completion and LSP (load when needed)
	{ import = "plugins.blink-cmp" },
	{ import = "plugins.none-ls" },

	-- Syntax and parsing
	{ import = "plugins.treesitter" },

	-- File navigation and management (load on command or key)
	{ import = "plugins.fzf-lua" },
	{ import = "plugins.avante" },
	{ import = "plugins.obsidian-nvim" },

	-- Git integration
	{ import = "plugins.gitblame" },

	-- Editing enhancements
	{ import = "plugins.mini-surround" },
	{ import = "plugins.otter" },

	-- Window management
	{ import = "plugins.tmux-navigator" },

	-- Diagnostics and help
	{ import = "plugins.trouble" },
	{ import = "plugins.which-key" },

	-- -- Environmental Variables
	{ import = "plugins.ecolog" },
})
