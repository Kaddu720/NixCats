return {
	"none-ls.nvim",
	event = "LspAttach",
	after = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- lua
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.selene.with({
					cwd = function(_params)
						return vim.fn.getcwd()
					end,
				}),

				-- python
				null_ls.builtins.formatting.isort,
				null_ls.builtins.diagnostics.mypy,

				-- nix
				null_ls.builtins.formatting.alejandra,
				null_ls.builtins.diagnostics.deadnix,

				-- yaml
				null_ls.builtins.diagnostics.yamllint,

				-- bash
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.diagnostics.dotenv_linter,

				-- markdown
				null_ls.builtins.diagnostics.vale,
			},
		})

		vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "[F]or[M]at" })
	end,
}
