local function helm_root_dir(bufnr, on_dir)
	local markers = {
		"Chart.yaml",
		"Chart.yml",
		"helmfile.yaml",
		"helmfile.yml",
		".git",
	}

	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then
		on_dir(vim.uv.cwd())
		return
	end

	local root = vim.fs.root(name, markers)
	on_dir(root or vim.fs.dirname(name))
end

return {
	cmd = { "helm_ls", "serve" },
	filetypes = { "helm" },
	root_dir = helm_root_dir,
	workspace_required = false,
	flags = {
		debounce_text_changes = 300,
	},
	settings = {
		["helm-ls"] = {
			yamlls = {
				path = "yaml-language-server",
			},
		},
	},
}
