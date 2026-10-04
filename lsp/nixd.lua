return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", "shell.nix", "default.nix" },
	settings = {
		["nixd"] = {
			formatting = {
				command = { "alejandra" },
			},
			diagnostics = {},
			nix = {
				flake = {
					autoEvalInputs = true,
				},
			},
		},
	},
}
