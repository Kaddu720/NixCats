return {
	"git-blame.nvim",
	ft = { "gitcommit", "gitrebase" }, -- or only load for specific git-related buffers
	event = "BufReadPost *", -- Load after any file is read
	after = function()
		-- Disable git blame background highlight to preserve CursorLine
		vim.g.gitblame_highlight_group = "Comment"
		vim.g.gitblame_set_extmark_options = {
			hl_mode = "combine" -- Don't override CursorLine highlight
		}
	end,
}
