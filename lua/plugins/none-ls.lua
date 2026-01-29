return {
	"none-ls.nvim",
	event = "LspAttach",
	after = function()
		local null_ls = require("null-ls")

		local sources = {
			-- lua
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.diagnostics.selene.with({
				condition = function(utils)
					return utils.root_has_file({ "selene.toml" })
				end,
			}),

			-- python
			null_ls.builtins.diagnostics.mypy,

			-- nix
			null_ls.builtins.formatting.alejandra,
			null_ls.builtins.diagnostics.deadnix,

			-- yaml
			null_ls.builtins.diagnostics.yamllint,

			-- bash
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.diagnostics.dotenv_linter,
		}

		-- Only add Vale for markdown if we're in a directory with .vale.ini
		-- This is registered dynamically when entering markdown files
		local vale_registered = false
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				if vale_registered then
					return
				end
				-- Search up from current file for .vale.ini
				local file_dir = vim.fn.expand("%:p:h")
				local dir = file_dir
				while dir ~= "/" and dir ~= "" do
					if vim.fn.filereadable(dir .. "/.vale.ini") == 1 then
						null_ls.register(null_ls.builtins.diagnostics.vale.with({
							filetypes = { "markdown" },
							cwd = function()
								return dir
							end,
						}))
						vale_registered = true
						return
					end
					dir = vim.fn.fnamemodify(dir, ":h")
				end
			end,
		})

		null_ls.setup({ sources = sources })

		vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "[F]or[M]at" })
	end,
}
