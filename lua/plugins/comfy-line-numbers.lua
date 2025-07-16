return {
	"comfy-line-numbers",
	event = "BufReadPost",
	after = function()
		require("comfy-line-numbers").setup({})
	end,
}
