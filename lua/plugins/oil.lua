return {
	"oil.nvim",
	after = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
			float = {
				-- Other float settings...

				-- Set winblend to 0 to avoid any background color issues
				winblend = 0,

				-- Directly set win_options
				win_options = {
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
				},
			},
		})
		vim.keymap.set("n", "-", "<Cmd>Oil --float<CR>", {})
	end,
}
