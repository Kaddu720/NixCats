return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml" },
	root_markers = { ".git" },
	workspace_required = false,
	flags = {
		debounce_text_changes = 300,
	},
	settings = {
		yaml = {
			schemas = {
				-- Kubernetes (multiple patterns for common conventions)
				["kubernetes"] = {
					"*.k8s.yaml",
					"**/k8s/**/*.yaml",
					"**/kubernetes/**/*.yaml",
					"**/manifests/**/*.yaml",
					"**/deploy/**/*.yaml",
					"deployment.yaml",
					"service.yaml",
					"configmap.yaml",
					"secret.yaml",
					"ingress.yaml",
					"cronjob.yaml",
					"daemonset.yaml",
					"statefulset.yaml",
				},
				-- GitHub Actions
				["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yaml",
				["https://json.schemastore.org/github-action.json"] = "action.yaml",
				-- Docker Compose
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
					"docker-compose*.yaml",
					"docker-compose*.yml",
					"compose*.yaml",
					"compose*.yml",
				},
				-- Helm Chart.yaml
				["https://json.schemastore.org/chart.json"] = "Chart.yaml",
				-- Helmfile
				["https://json.schemastore.org/helmfile.json"] = {
					"helmfile.yaml",
					"helmfile.d/*.yaml",
					"**/helmfile.d/*.yaml",
				},
				-- Kustomization
				["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
			},
			validate = true,
			schemaStore = {
				enable = true, -- Enable schemastore for additional schemas
			},
		},
	},
}
