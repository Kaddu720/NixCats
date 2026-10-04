local function python_root_dir(bufnr, on_dir)
	local markers = {
		"pyproject.toml",
		"ruff.toml",
		".ruff.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
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

-- Linting/formatting companion for Python; ty owns language intelligence now.
return {
	name = "ruff",
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_dir = python_root_dir,
	workspace_required = false,
	flags = {
		debounce_text_changes = 300,
	},
	settings = {},
}
