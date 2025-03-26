return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yml" },
	root_markers = { ".git" },
	formatters = {
		ignoreComments = false,
	},
	settings = {
		yaml = {
			schemas = {},
			validate = true,
		},
	},
}
