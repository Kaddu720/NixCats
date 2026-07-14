local vaults = { vim.fs.normalize("~/Vaults/Second_Brain"), vim.fs.normalize("~/Vaults/Work_Brain") }
local function vault_root(bufnr, on_dir)
	local name = vim.api.nvim_buf_get_name(bufnr)
	for _, vault in ipairs(vaults) do
		if name:sub(1, #vault + 1) == vault .. "/" then
			on_dir(vault)
			return
		end
	end
end
return {
	cmd = { "ltex-ls-plus" },
	filetypes = { "markdown", "text", "latex", "tex" },
	root_dir = vault_root,
	settings = { ltex = {} },
}
