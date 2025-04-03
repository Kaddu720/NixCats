return {
	{
		"mini.surround",
		keys = {
			{ "sa", mode = { "n", "v" }, desc = "[S]uround [A]dd" },
			{ "sd", mode = "n", desc = "[S]uround [D]elete" },
			{ "sr", mode = "n", desc = "[S]uround [R]eplace" },
		},
		after = function()
			require("mini.surround").setup()
		end,
	},
	{
		"mini.pairs",
		keys = {
			{ "[", mode = "i" },
			{ "{", mode = "i" },
			{ "'", mode = "i" },
			{ '"', mode = "i" },
			{ "<", mode = "i" },
			{ "(", mode = "i" },
		},
		after = function()
			require("mini.pairs").setup()
		end,
	},
}
