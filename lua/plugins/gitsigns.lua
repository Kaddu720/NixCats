return {
	"gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	after = function()
		local registry = require("config.keymaps_registry")
		require("gitsigns").setup({
			attach_to_untracked = true,
			current_line_blame = true,
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "│" },
			},
			on_attach = function(bufnr)
				registry.gitsigns(bufnr, package.loaded.gitsigns)
			end,
		})
		-- The buffer that triggered the load has already fired BufReadPost; attach it explicitly.
		require("gitsigns").attach()
	end,
}
