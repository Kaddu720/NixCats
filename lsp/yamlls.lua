local function yaml_root_dir(bufnr, on_dir)
	local markers = { ".git" }
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then
		on_dir(vim.uv.cwd())
		return
	end

	local root = vim.fs.root(name, markers)
	on_dir(root or vim.fs.dirname(name))
end

return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yml" },
	root_dir = yaml_root_dir,
	workspace_required = false,
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
			},
			validate = true,
			schemaStore = {
				enable = true, -- Enable schemastore for additional schemas
			},
		},
	},
}
