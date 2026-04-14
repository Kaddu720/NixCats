local function terraform_root_dir(bufnr, on_dir)
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then
		on_dir(vim.uv.cwd())
		return
	end

	if name:match("/%.terraform/") then
		return
	end

	local markers = { ".terraform", "terraform.tf", "terraform.tfvars", ".git" }
	local root = vim.fs.root(name, markers)
	on_dir(root or vim.fs.dirname(name))
end

return {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "tf", "terraform-vars" },
	root_dir = terraform_root_dir,
	formatters = {
		ignoreComments = false,
	},
	settings = {},
}
