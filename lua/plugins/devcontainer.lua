return {
	"dev-container",
	on_require = "devcontainer",
	cmd = {
		"DevcontainerStart",
		"DevcontainerAttach",
		"DevcontainerExec",
		"DevcontainerEditNearestConfig",
	},
	after = function()
		require("devcontainer").setup({})

		local keymap = require("utils.keymap")
		keymap.set("n", "<leader>ds", "<Cmd>DevcontainerStart<CR>", { desc = "[D]evcontainer [S]tart" })
		keymap.set("n", "<leader>da", "<Cmd>DevcontainerAttach<CR>", { desc = "[D]evcontainer [A]ttach" })
		keymap.set("n", "<leader>de", "<Cmd>DevcontainerExec<CR>", { desc = "[D]evcontainer [E]xec" })
		keymap.set(
			"n",
			"<leader>dc",
			"<Cmd>DevcontainerEditNearestConfig<CR>",
			{ desc = "[D]evcontainer [C]onfig" }
		)
	end,
}
