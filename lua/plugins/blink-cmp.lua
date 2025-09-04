return {
	{
		"friendly-snippets",
		dep_of = { "blink.cmp" },
	},
	{
		"blink.cmp",
		event = { "InsertEnter" },
		after = function()
			require("blink.cmp").setup({
				-- keymap
				keymap = { preset = "enter" },

				-- Styling
				completion = {
					menu = {
						border = "rounded",
						winhighlight = "Normal:None,FloatBorder:BlinkCmpDocBorder,CursorLine:CursorLine,Search:None",
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 150, -- Performance: Increased from 50ms
						window = {
							border = "rounded",
						},
					},
					list = {
						selection = {
							preselect = false,
						},
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer", "ecolog" },
					providers = {
						ecolog = { 
							name = "ecolog", 
							module = "ecolog.integrations.cmp.blink_cmp",
							max_items = 5, -- Performance: Limit ecolog completions
						},
						buffer = {
							max_items = 8, -- Performance: Limit buffer completions
						},
						path = {
							max_items = 8, -- Performance: Limit path completions
						},
					},
				},
			})
		end,
	},
}
