return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yml" },
	root_markers = { ".git" },
	formatters = {
		ignoreComments = false,
	},
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
				-- ArgoCD
				["https://raw.githubusercontent.com/argoproj/argo-cd/master/pkg/apis/application/v1alpha1/types.go"] = "**/argocd/**/*.yaml",
			},
			validate = true,
			schemaStore = {
				enable = true, -- Enable schemastore for additional schemas
			},
		},
	},
}
