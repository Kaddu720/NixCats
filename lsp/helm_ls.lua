return {
	cmd = { "helm_ls", "serve" },
	filetypes = { "helm" },
	-- One group: the nearest directory containing any marker wins.
	root_markers = { { "Chart.yaml", "Chart.yml", "helmfile.yaml", "helmfile.yml", ".git" } },
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
