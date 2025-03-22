-- Measure startup time
local start_time = vim.fn.reltime()

-- Set up performance options early
-- vim.opt.lazyredraw = true
vim.opt.shadafile = "NONE" -- Don't read or write shada file on startup

-- Load core configuration
require("config.options")
require("plugins")
require("config.keymaps")

-- Defer non-critical operations
vim.defer_fn(function()
	-- Re-enable shada after startup
	vim.opt.shadafile = ""
	vim.cmd([[silent! rshada]])

	-- Print startup time
	if vim.g.startup_time_enabled then
		local end_time = vim.fn.reltime(start_time)
		local startup_time = vim.fn.reltimefloat(end_time) * 1000
		print(string.format("Neovim loaded in %.2f ms", startup_time))
	end
end, 100)
