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
				winopts = {
					border = "rounded",
					preview = {
						delay = 100,
						border = "rounded",
						layout = "horizontal",
						horizontal = "right:60%",
					},
					backdrop = 100,
				},
				fzf_opts = {
					["--layout"] = "reverse",
					["--prompt"] = ">  ",
				},
				fzf_colors = {
					["bg"] = { "bg", "Normal" },
					["bg+"] = { "bg", "Normal" },
					["gutter"] = { "bg", "Normal" },
					["border"] = "#e0def4",
					["label"] = "#e0def4",
					["pointer"] = "#f7768e",
				},
			})
			require("fzf-lua").register_ui_select()

			-- Performance: Removed vim.cmd("wal") from all keymaps
			vim.keymap.set("n", "<leader>fa", require("fzf-lua").files, { desc = "[F]zf [A]ppend" })
			vim.keymap.set("n", "<leader>ff", require("fzf-lua").buffers, { desc = "[F]z[F] buffer list" })
			vim.keymap.set("n", "<leader>fs", require("fzf-lua").treesitter, { desc = "[F]zf Symbols list" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", require("fzf-lua").lsp_code_actions, { desc = "[C]ode [A]ctions" })
			vim.keymap.set("n", "<leader>fw", require("fzf-lua").live_grep, { desc = "[F]ind [W]ord" })
		end,
	},
}
