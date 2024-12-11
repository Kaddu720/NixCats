return {
	"snacks.nvim",
	lazy = false,
	after = function()
		require("snacks").setup({
			notifier = { enabled = true },
			lazygit = {
				enabled = true,
        configure = false,
        theme = nil
			},
		})

		vim.keymap.set("n", "<leader>l", function()
			Snacks.lazygit.open()
		end, { desc = "[L]azygit" })
	end,
}
