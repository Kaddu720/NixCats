return {
	"none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		local null_ls = require("null-ls")
		local builtins = null_ls.builtins

		local function has_exec(cmd)
			return vim.fn.executable(cmd) == 1
		end

		local function add_if_exec(sources, cmd, source)
			if has_exec(cmd) then
				table.insert(sources, source)
			end
		end

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

		local sources = {}

		-- lua
		add_if_exec(sources, "stylua", builtins.formatting.stylua)
		add_if_exec(
			sources,
			"selene",
			builtins.diagnostics.selene.with({
				condition = function(utils)
					return utils.root_has_file({ "selene.toml" })
				end,
			})
		)

		-- python
		add_if_exec(sources, "mypy", builtins.diagnostics.mypy)

		-- nix
		add_if_exec(sources, "alejandra", builtins.formatting.alejandra)
		add_if_exec(sources, "deadnix", builtins.diagnostics.deadnix)

		-- yaml
		add_if_exec(sources, "yamllint", builtins.diagnostics.yamllint)

		-- markdown
		add_if_exec(
			sources,
			"vale",
			builtins.diagnostics.vale.with({
				filetypes = { "markdown" },
				runtime_condition = function(params)
					return find_vale_root(params.bufname) ~= nil
				end,
				cwd = function(params)
					return find_vale_root(params.bufname)
				end,
			})
		)

		-- bash
		add_if_exec(sources, "shfmt", builtins.formatting.shfmt)
		add_if_exec(sources, "dotenv-linter", builtins.diagnostics.dotenv_linter)

		null_ls.setup({ sources = sources })
	end,
}
