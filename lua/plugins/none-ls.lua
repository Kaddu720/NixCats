return {
	"none-ls.nvim",
	event = "LspAttach",
	after = function()
		local null_ls = require("null-ls")
		local registry = require("config.keymaps_registry")

		local function find_vale_root(bufname)
			if not bufname or bufname == "" then
				return nil
			end
			local dir = vim.fn.fnamemodify(bufname, ":p:h")
			local found = vim.fs.find(".vale.ini", { path = dir, upward = true })[1]
			if not found then
				return nil
			end
			return vim.fn.fnamemodify(found, ":h")
		end

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

			-- markdown
			null_ls.builtins.diagnostics.vale.with({
				filetypes = { "markdown" },
				runtime_condition = function(params)
					return find_vale_root(params.bufname) ~= nil
				end,
				cwd = function(params)
					return find_vale_root(params.bufname)
				end,
			}),

			-- bash
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.diagnostics.dotenv_linter,
		}

		null_ls.setup({ sources = sources })
		registry.none_ls()
	end,
}
