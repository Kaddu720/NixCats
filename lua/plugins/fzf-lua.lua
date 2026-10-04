return {
	{
		"fzf-lua",
		dep_of = { "obsidian" },
		keys = require("config.keymaps_registry").lazy_keys.fzf_lua,
		after = function()
			local registry = require("config.keymaps_registry")
			require("fzf-lua").setup({
				winopts = {
					border = "rounded",
					preview = {
						delay = 100,
						border = "rounded",
						layout = "horizontal",
						horizontal = "right:60%",
					},
					backdrop = 100,
				},
				fzf_opts = {
					["--layout"] = "reverse",
					["--prompt"] = ">  ",
				},
				fzf_colors = {
					["bg"] = { "bg", "Normal" },
					["bg+"] = { "bg", "Normal" },
					["gutter"] = { "bg", "Normal" },
					["border"] = "#e0def4",
					["label"] = "#e0def4",
					["pointer"] = "#f7768e",
				},
			})

			-- List code actions from these servers last (e.g. ltex spelling before
			-- obsidian's note actions). Wraps fzf-lua's select itself, since
			-- register_ui_select() checks vim.ui.select against this function.
			local deprioritized = { ["obsidian-ls"] = true }
			local ui_select = require("fzf-lua.providers.ui_select")
			local fzf_select = ui_select.ui_select
			ui_select.ui_select = function(items, opts, on_choice)
				if opts and opts.kind == "codeaction" then
					local first, last = {}, {}
					for _, item in ipairs(items) do
						local client = item.ctx and vim.lsp.get_client_by_id(item.ctx.client_id)
						table.insert((client and deprioritized[client.name]) and last or first, item)
					end
					items = vim.list_extend(first, last)
				end
				return fzf_select(items, opts, on_choice)
			end
			require("fzf-lua").register_ui_select()
			registry.fzf_lua()
		end,
	},
}
