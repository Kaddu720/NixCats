return {
	"trouble.nvim",
	keys = require("config.keymaps_registry").lazy_keys.trouble,
	after = function()
		local registry = require("config.keymaps_registry")
		local trouble = require("trouble")
		local symbols = trouble.statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = false,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			-- The following line is needed to fix the background color
			-- Set it to the lualine section you want to use
			hl_group = "lualine_c_normal",
		})
		-- table.insert(opts.sections.lualine_c, {
		--   symbols.get,
		--   cond = symbols.has,
		-- })
		registry.trouble()
	end,
}
