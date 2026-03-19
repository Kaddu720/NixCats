local function docker_root_dir(bufnr, on_dir)
	local markers = { "Dockerfile", ".dockerignore", ".git" }
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then
		on_dir(vim.uv.cwd())
		return
	end

	local root = vim.fs.root(name, markers)
	on_dir(root or vim.fs.dirname(name))
end

return {
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_dir = docker_root_dir,
	workspace_required = false,
	flags = {
		debounce_text_changes = 300,
	},
}
