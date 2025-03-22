require("lze").load({
  -- Core plugins that should load immediately
  { import = "plugins.rose-pine" },
  { import = "plugins.plenary" },

  -- UI elements with lazy loading
  { import = "plugins.lualine",        event = "VeryLazy" },
  { import = "plugins.snacks-nvim",    event = "VeryLazy" },
  { import = "plugins.noice",          event = "VeryLazy" },

  -- Completion and LSP (load when needed)
  { import = "plugins.blink-cmp",      event = "InsertEnter" },
  { import = "plugins.lsp",            event = { "BufReadPre", "BufNewFile" } },
  { import = "plugins.none-ls",        event = { "BufReadPre", "BufNewFile" } },

  -- Syntax and parsing
  { import = "plugins.treesitter",     event = { "BufReadPost", "BufNewFile" } },

  -- File navigation and management (load on command or key)
  { import = "plugins.fzf-lua",        event = "VeryLazy" },
  { import = "plugins.oil-nvim",       cmd = "Oil" },
  { import = "plugins.avante",         event = "VeryLazy" },
  { import = "plugins.obsidian-nvim",  ft = "markdown" },
  { import = "plugins.harpoon",        event = "VeryLazy" },

  -- Git integration
  { import = "plugins.gitblame",       event = { "BufReadPost", "BufNewFile" } },

  -- File explorer and navigation
  { import = "plugins.neo-tree",       cmd = "Neotree" },

  -- Editing enhancements
  { import = "plugins.nvim-autopairs", event = "InsertEnter" },
  { import = "plugins.otter",          ft = { "markdown", "quarto" } },

  -- Window management
  { import = "plugins.tmux-navigator", event = "VeryLazy" },

  -- Diagnostics and help
  { import = "plugins.trouble",        cmd = { "Trouble", "TroubleToggle" } },
  { import = "plugins.which-key",      event = "VeryLazy" },

  -- Theme and visuals
  { import = "plugins.ecolog",         event = "VeryLazy" },
})
