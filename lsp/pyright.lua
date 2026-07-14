return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	single_file_support = true,
	settings = {
		pyright = { disableOrganizeImports = true },
		python = {
			analysis = {
				ignore = { "*" },
				typeCheckingMode = "off",
				autoSearchPaths = false,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
}
