return {
	"nvim-autopairs",
	event = "InsertEnter",
	keys = {
		{ "<C-s>", mode = "i", desc = "Fast wrap with autopairs" },
	},
	after = function()
		local npairs = require("nvim-autopairs")
		npairs.setup({
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<C-s>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0,
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
				cursor_pos_before = false,
			},
		})
	end,
}
