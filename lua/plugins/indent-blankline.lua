return {
	"indent-blankline.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("ibl").setup({
			indent = {
				char = "│",
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = true,
				highlight = { "Function", "Label" },
			},
		})
	end,
}
