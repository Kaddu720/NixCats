-- Plugin specs auto-discovered from lua/plugins/*.lua
-- NOTE: plugin binaries and LSPs must also be added to flake.nix
local function plugin_imports()
	local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
	local files = vim.fn.glob(plugin_dir .. "/*.lua", false, true)
	table.sort(files)

	local imports = {}
	for _, file in ipairs(files) do
		local name = vim.fn.fnamemodify(file, ":t:r")
		if name ~= "init" then
			table.insert(imports, { import = "plugins." .. name })
		end
	end
	return imports
end

local specs = {
	-- Core dependency ordering
	{ "plenary.nvim", dep_of = { "none-ls.nvim" } },
	{ "nvim-web-devicons", dep_of = { "fzf-lua" } },
}
vim.list_extend(specs, plugin_imports())

require("lze").load(specs)
