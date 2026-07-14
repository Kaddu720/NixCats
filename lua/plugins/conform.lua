return {
	"conform.nvim",
	on_require = "conform",
	cmd = { "ConformInfo" },
	after = function()
		require("conform").setup({
			formatters_by_ft = { lua = { "stylua" }, nix = { "alejandra" }, sh = { "shfmt" }, bash = { "shfmt" } },
		})
	end,
}
