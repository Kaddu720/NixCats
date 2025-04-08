
-- Set up performance options early
-- vim.opt.lazyredraw = true
vim.opt.shadafile = "NONE" -- Don't read or write shada file on startup

-- Load core configuration
require("config.options")
require("config.keymaps")
require("plugins")



-- Defer non-critical operations
vim.defer_fn(function()
	-- Re-enable shada after startup
	vim.opt.shadafile = ""
	vim.cmd([[silent! rshada]])

end, 100)
