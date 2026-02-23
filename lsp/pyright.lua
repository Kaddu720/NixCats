-- Completions only; type-checking disabled (handled by mypy via none-ls)
return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	single_file_support = true, -- Allow Pyright to work on standalone .py files
	formatters = {
		ignoreComments = false,
	},
	flags = {
		debounce_text_changes = 300, -- Performance: Less frequent updates
	},
	settings = {
		pyright = {
			disableOrganizeImports = true, -- Using Ruff
		},
		python = {
			analysis = {
				ignore = { "*" }, -- Using Ruff
				typeCheckingMode = "off", -- Using mypy - completely disable
				autoSearchPaths = false, -- Performance: Disable auto path search
				diagnosticMode = "openFilesOnly", -- Performance: Only check open files
			},
		},
	},
}
