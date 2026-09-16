return {
	"otter.nvim",
	on_plugin = "nvim-treesitter",
	ft = { "nix", "markdown" },
	after = function()
		local otter = require("otter")
		local languages = {
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
				diagnostic_update_events = { "BufWritePost" },
				root_dir = function(_, bufnr)
					return vim.fs.root(bufnr or 0, { ".git", "_quarto.yml", "package.json" }) or vim.fn.getcwd(0)
				end,
			},
			buffers = { write_to_disk = false },
			strip_wrapping_quote_characters = { "'", '"', "`" },
			handle_leading_whitespace = true,
			extensions = { jsonc = "jsonc", nu = "nu", terraform = "tf", toml = "toml" },
		})
		local group = vim.api.nvim_create_augroup("OtterAutoActivate", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = { "markdown", "nix" },
			callback = function(args)
				if vim.b[args.buf].otter_auto_activation_pending then
					return
				end
				vim.b[args.buf].otter_auto_activation_pending = true
				vim.schedule(function()
					if not vim.api.nvim_buf_is_valid(args.buf) then
						return
					end
					local keeper = require("otter.keeper")
					if keeper.rafts[args.buf] then
						return
					end
					vim.api.nvim_buf_call(args.buf, function()
						otter.activate(languages, true, true)
					end)
					vim.b[args.buf].otter_auto_activation_pending = nil
				end)
			end,
		})
	end,
}
