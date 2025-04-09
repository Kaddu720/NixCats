-- Measure startup time
local start_time = vim.fn.reltime()

require("config")

-- Print startup time
if vim.g.startup_time_enabled then
	local end_time = vim.fn.reltime(start_time)
	local startup_time = vim.fn.reltimefloat(end_time) * 1000
	print(string.format("Neovim loaded in %.2f ms", startup_time))
end
