return {
	"otter.nvim",
	on_plugin = "nvim-treesitter",
	ft = { "nix", "markdown" },
	after = function()
		local otter = require("otter")
		local otter_languages = {
			"bash",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"nix",
			"nu",
			"python",
			"sh",
			"terraform",
			"toml",
			"vim",
			"yaml",
		}

		otter.setup({
			lsp = {
				-- `:h events` that cause the diagnostics to update. Set to:
				-- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
				-- but more instant diagnostic updates
				diagnostic_update_events = { "BufWritePost" },
				-- function to find the root dir where the otter-ls is started
				root_dir = function(_, bufnr)
					return vim.fs.root(bufnr or 0, {
						".git",
						"_quarto.yml",
						"package.json",
					}) or vim.fn.getcwd(0)
				end,
			},
			buffers = {
				write_to_disk = false,
			},
			strip_wrapping_quote_characters = { "'", '"', "`" },
			-- otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
			-- When true, otter handles these cases fully.
			handle_leading_whitespace = true,
			extensions = {
				jsonc = "jsonc",
				nu = "nu",
				terraform = "tf",
				toml = "toml",
			},
		})

		local group = vim.api.nvim_create_augroup("OtterAutoActivate", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = { "markdown", "nix" },
			callback = function(args)
				vim.schedule(function()
					if not vim.api.nvim_buf_is_valid(args.buf) then
						return
					end

					local keeper = require("otter.keeper")
					if keeper.rafts[args.buf] ~= nil then
						return
					end

					vim.api.nvim_buf_call(args.buf, function()
						otter.activate(otter_languages, true, true)
					end)
				end)
			end,
		})
	end,
}
