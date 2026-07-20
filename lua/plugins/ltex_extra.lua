if not require("nixCats")("writing") then
	return {}
end

return {
	{
		"ltex_extra.nvim",
		dep_of = "obsidian",
		after = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LtexExtraConfig", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client or (client.name ~= "ltex" and client.name ~= "ltex_plus") then
						return
					end
					local ok, ltex_extra = pcall(require, "ltex_extra")
					if ok then
						ltex_extra.setup({
							load_langs = { "en-US" },
							init_check = false,
							path = vim.fn.expand("~/.local/share/ltex"),
							log_level = "none",
						})
					end
				end,
			})
		end,
	},
}
