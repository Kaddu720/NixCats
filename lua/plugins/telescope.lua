return {
	{
		"telescope-ui-select.nvim",
		on_plugin = "telescope.nvim",
	},
	{
		"telescope-fzf-native.nvim",
		on_plugin = "telescope.nvim",
	},
	{
		"telescope.nvim",
    event = "DeferredUIEnter",
		after = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]ile" })
			vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "[F]ind [W]ord" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffer" })
			vim.keymap.set("n", "<leader>fh", "<Cmd>Telescope harpoon marks<CR>", { desc = "[F]ind [H]arpoon" })

			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
			-- require("telescope").load_extension("fzf-native")
		end,
	},
}
