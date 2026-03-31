return {
	"conform.nvim",
	event = { "BufWritePre" },
	keys = {
		{ "<leader>cf", mode = { "n", "v" }, desc = "[C]ode [F]ormat" },
	},
	cmd = { "ConformInfo" },
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
