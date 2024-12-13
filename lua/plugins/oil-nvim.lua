return {
	"oil.nvim",
  lazy = false,
	after = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
		})
		vim.keymap.set("n", "-", "<Cmd>Oil --float<CR>", {})
	end,
}
