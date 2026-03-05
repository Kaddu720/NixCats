return {
	"conform.nvim",
	event = { "BufWritePre", "BufWritePost" },
	after = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "alejandra" },
				sh = { "shfmt" },
				bash = { "shfmt" },
			},
		})
	end,
}
