
-- Load core configuration
require("config.options")
require("config.keymaps")
require("config.colorscheme")
require("config.language")
require("plugins")

-- Defer non-critical operations
vim.defer_fn(function()
	-- Re-enable shada after startup
	vim.opt.shadafile = ""
	vim.cmd([[silent! rshada]])
end, 100)
