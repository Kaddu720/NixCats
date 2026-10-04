-- Registered as filetype patterns (not a BufRead autocmd) so the buffer is
-- never detected as yaml first, which would attach yamlls to Helm templates.
local function chart_template(path)
	if vim.fs.root(path, { "Chart.yaml", "Chart.yml" }) then
		return "helm"
	end
end

vim.filetype.add({
	pattern = {
		[".*/templates/.*%.ya?ml"] = chart_template,
		[".*/templates/.*%.tpl"] = chart_template,
		[".*/templates/.*%.txt"] = chart_template,
		[".*%.gotmpl"] = "helm",
		["helmfile.*%.ya?ml"] = "helm",
	},
})
