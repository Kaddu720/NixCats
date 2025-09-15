return {
	{
		"rose-pine",
		dep_of = "obsidian",
		ft = "markdown",
		name = "rose-pine",
		after = function()
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#333333" })
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	}
}
