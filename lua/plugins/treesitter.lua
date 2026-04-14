return {
	{
		"nvim-treesitter",
		event = "DeferredUIEnter",
		after = function()
			local function should_start_treesitter(bufnr)
				if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
					return false
				end

				local name = vim.api.nvim_buf_get_name(bufnr)
				if name == "" then
					return true
				end

				if name:match("/%.terraform/") then
					return false
				end

				local ok, stat = pcall(vim.uv.fs_stat, name)
				if ok and stat and stat.size and stat.size > 200 * 1024 then
					return false
				end

				return true
			end

			local ok, nixCats = pcall(require, "nixCats")
			if ok then
				local grammar_path = nixCats.pawsible
					and nixCats.pawsible.allPlugins
					and nixCats.pawsible.allPlugins.ts_grammar_path
				if grammar_path
					and vim.fn.isdirectory(grammar_path) == 1
					and not vim.o.runtimepath:find(grammar_path, 1, true)
				then
					vim.opt.runtimepath:append(grammar_path)
				end
			end

			-- Enable treesitter highlighting for supported filetypes
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if should_start_treesitter(args.buf) then
						pcall(vim.treesitter.start, args.buf)
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter-textobjects",
		event = "DeferredUIEnter",
		dep_of = { "nvim-treesitter" },
		after = function()
			local registry = require("config.keymaps_registry")
			registry.treesitter_textobjects()
		end,
	},
	{
		"nvim-treesitter-context",
		event = "DeferredUIEnter",
		after = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 3,
				trim_scope = "outer",
			})
		end,
	},
}
