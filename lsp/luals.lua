return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	single_file_support = false, -- Performance: Don't activate on single files
	telemetry = { enabled = false },
	formatters = {
		ignoreComments = false,
	},
	flags = {
		debounce_text_changes = 300, -- Performance: Less frequent updates
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			signatureHelp = { enabled = true },
			workspace = {
				checkThirdParty = false, -- Performance: Skip third-party checks
			},
			diagnostics = {
				workspaceDelay = 3000, -- Performance: Delay workspace diagnostics
			},
		},
	},
}
