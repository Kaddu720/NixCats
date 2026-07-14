return {
	cmd = { "nil" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", "shell.nix", "default.nix" },
	settings = {
		["nil"] = {
			formatting = { command = { "alejandra" } },
			diagnostics = { excludedFiles = { ".*nvim-config.*", ".*nix-homebrew.*" } },
			nix = { flake = { autoArchive = true, autoEvalInputs = false } },
		},
	},
}
