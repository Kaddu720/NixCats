return {
	"gitsigns.nvim",
	event = "BufReadPost",
	after = function()
		local registry = require("config.keymaps_registry")
		require("gitsigns").setup({
			attach_to_untracked = true,
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 300,
			},
			current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "│" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				registry.gitsigns(bufnr, gs)
			end,
		})
	end,
}
