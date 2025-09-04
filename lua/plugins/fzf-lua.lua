return {
	{
		"fzf-lua",
		dep_of = { "obsidian" },
		keys = {
			{ "<leader>fa", mode = "n", desc = "[F]zf [A]ppend" },
			{ "<leader>ff", mode = "n", desc = "[F]z[F] buffer list" },
			{ "<leader>ca", mode = { "n", "v" }, desc = "[C]ode [A]ctions" },
			{ "<leader>fw", mode = "n", desc = "[F]ind [W]ord" },
		},
		after = function()
			require("fzf-lua").setup({
				-- Performance: Optimize for speed
				winopts = {
					preview = {
						delay = 100, -- Performance: Delay preview updates
					},
				},
			})
			require("fzf-lua").register_ui_select()

			-- Performance: Removed vim.cmd("wal") from all keymaps
			vim.keymap.set("n", "<leader>fa", require("fzf-lua").files, { desc = "[F]zf [A]ppend" })
			vim.keymap.set("n", "<leader>ff", require("fzf-lua").buffers, { desc = "[F]z[F] buffer list" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", require("fzf-lua").lsp_code_actions, { desc = "[C]ode [A]ctions" })
			vim.keymap.set("n", "<leader>fw", require("fzf-lua").live_grep, { desc = "[F]ind [W]ord" })
		end,
	},
}
