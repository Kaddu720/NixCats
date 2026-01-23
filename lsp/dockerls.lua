return {
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_markers = { "Dockerfile", ".dockerignore" },
	flags = {
		debounce_text_changes = 300,
	},
}
