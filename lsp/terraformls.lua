return {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "tf", "terraform-vars" },
	root_markers = { ".terraform", "terraform.tf", "terraform.tfvars" },
	formatters = {
		ignoreComments = false,
	},
	settings = {},
}
