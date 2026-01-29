return {
	"comfy-line-numbers",
	event = "DeferredUIEnter",
	after = function()
		require("comfy-line-numbers").setup({})
	end,
}
