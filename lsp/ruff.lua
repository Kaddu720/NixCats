return {
	name = "ruff",
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml" },
	formatters = {
		ignoreComments = false,
	},
	settings = {},
}
