return {
	{
		"ltex_extra.nvim",
		dep_of = "obsidian",
		ft = "markdown",
		after = function()
			local ltex_extra_setup_done = false
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LtexExtraConfig", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if
						client
						and (client.name == "ltex" or client.name == "ltex_plus")
						and not ltex_extra_setup_done
					then
						local ok, ltex_extra = pcall(require, "ltex_extra")
						if ok then
							pcall(ltex_extra.setup, {
								load_langs = { "en-US" },
								init_check = true,
								path = vim.fn.expand("~/.local/share/ltex"),
								log_level = "none",
							})
							ltex_extra_setup_done = true
						else
							vim.notify("Failed to load ltex_extra.nvim", vim.log.levels.WARN)
						end
					end
				end,
			})
		end,
	}
}
