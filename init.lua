-- Measure startup time
local start_time = vim.fn.reltime()

-- Set up performance options early
vim.opt.laststatus = 0 -- disable default status line
vim.opt.shadafile = "NONE" -- Don't read or write shada file on startup

require("config")

-- Print startup times (config load + total until UI ready)
if vim.g.startup_time_enabled then
	local config_time = vim.fn.reltimefloat(vim.fn.reltime(start_time)) * 1000
	print(string.format("Config loaded in %.2f ms", config_time))

	vim.api.nvim_create_autocmd("UIEnter", {
		once = true,
		callback = function()
			local total_time = vim.fn.reltimefloat(vim.fn.reltime(start_time)) * 1000
			print(string.format("UI ready in %.2f ms (total)", total_time))
		end,
	})
end
