return {
	{
		"nvim-treesitter",
		event = "DeferredUIEnter",
		after = function()
			-- Enable treesitter highlighting for supported filetypes
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},
	{
		"nvim-treesitter-textobjects",
		event = "DeferredUIEnter",
		dep_of = { "nvim-treesitter" },
		after = function()
			-- Textobject selection keymaps
			local select_maps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
			}
			for keymap, query in pairs(select_maps) do
				vim.keymap.set({ "x", "o" }, keymap, function()
					require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
				end, { desc = "Select " .. query })
			end

			-- Movement keymaps (go to next/prev function/class)
			local move = require("nvim-treesitter-textobjects.move")
			vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
			vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
			vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function start" })
			vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Prev function end" })
			vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class start" })
			vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class start" })
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
