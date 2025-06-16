return {
	"git-blame.nvim",
	ft = { "gitcommit", "gitrebase" }, -- or only load for specific git-related buffers
	event = "BufReadPost *", -- Load after any file is read
}
