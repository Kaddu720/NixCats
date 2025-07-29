return {
	{
		"flash.nvim",
		keys = {
			{ "/", mode = { "n", "x", "o" }, desc = "Search for Text" },
			{ "S", mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
			{ "r", mode = "o", desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, desc = "Toggle Flash Search" },
		},
		after = function()
			require("flash").setup({
				modes = {
					search = {
						enabled = true,
					},
					char = {
						jump_labels = true,
					},
				},
			})

			vim.keymap.set({ "n", "x", "o" }, "S", function()
				require("flash").treesitter()
			end, { desc = "Flash Treesitter" })

			vim.keymap.set({ "o" }, "r", function()
				require("flash").remote()
			end, { desc = "Remote Flash" })

			vim.keymap.set({ "o", "x" }, "R", function()
				require("flash").treesitter_search()
			end, { desc = "Treesitter Search" })

			vim.keymap.set({ "c" }, "<c-s>", function()
				require("flash").toggle()
			end, { desc = "Toggle Flash Search" })
		end,
	},
}
