return {
	{
		"nvim-treesitter",
		event = "DeferredUIEnter",
		after = function()
			-- Enable treesitter highlighting for supported filetypes
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},
	{
		"nvim-treesitter-textobjects",
		event = "DeferredUIEnter",
		dep_of = { "nvim-treesitter" },
		after = function()
			-- nvim-treesitter-textobjects requires nvim-treesitter.configs which was removed
			-- Textobjects are loaded as a dependency of nvim-treesitter but config API changed
			-- For now, just ensure the plugin is loaded - textobjects work via queries
		end,
	},
	{
		"nvim-treesitter-context",
		event = "DeferredUIEnter",
		after = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 3,
				trim_scope = "outer",
			})
		end,
	},
}
