local keymap = require("utils.keymap")

local M = {}

-- Core (non-plugin) keymaps
function M.core()
	keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })
	keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })
	keymap.set("n", "j", "gj", { desc = "Down (wrap aware)" })
	keymap.set("n", "k", "gk", { desc = "Up (wrap aware)" })

	keymap.set("n", "cd", function()
		local current_config = vim.diagnostic.config()
		local current_line_is_on = type(current_config.virtual_lines) == "table"
			and current_config.virtual_lines.current_line == true

		if current_line_is_on then
			vim.diagnostic.config({ virtual_lines = false })
		else
			vim.diagnostic.config({ virtual_lines = { current_line = true } })
		end
	end, { desc = "Toggle diagnostic virtual_lines: none vs current_line" })

	keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
	keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

	vim.defer_fn(function()
		local function nav(d)
			local dirs = { h = "L", j = "D", k = "U", l = "R" }
			local w = vim.api.nvim_get_current_win()
			vim.cmd("wincmd " .. d)
			if w == vim.api.nvim_get_current_win() and vim.env.TMUX then
				vim.fn.system("tmux select-pane -" .. dirs[d])
			end
		end
		keymap.set("n", "<C-h>", function() nav("h") end, { desc = "Move to left split (tmux-aware)" })
		keymap.set("n", "<C-j>", function() nav("j") end, { desc = "Move to split below (tmux-aware)" })
		keymap.set("n", "<C-k>", function() nav("k") end, { desc = "Move to split above (tmux-aware)" })
		keymap.set("n", "<C-l>", function() nav("l") end, { desc = "Move to right split (tmux-aware)" })
	end, 0)
end

-- LSP keymaps (buffer-local)
function M.lsp(bufnr)
	keymap.buf(bufnr, "n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
	keymap.buf(bufnr, "n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
	keymap.buf(bufnr, "n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
	keymap.buf(bufnr, "n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
end

-- Plugin: none-ls (lua/plugins/none-ls.lua)
function M.none_ls()
	keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "[F]or[M]at" })
end

-- Plugin: oil.nvim (lua/plugins/oil.lua)
function M.oil()
	keymap.set("n", "-", "<Cmd>Oil --float<CR>", { desc = "Open Oil (float)" })
end

-- Plugin: nvim-hlslens (lua/plugins/nvim-hlslens.lua)
function M.hlslens()
	keymap.set(
		"n",
		"n",
		[[<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
		{ desc = "Next search result (center + lens)" }
	)
	keymap.set(
		"n",
		"N",
		[[<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
		{ desc = "Prev search result (center + lens)" }
	)
	keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], {
		desc = "Search word under cursor (forward)",
	})
	keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], {
		desc = "Search word under cursor (backward)",
	})
	keymap.set("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], {
		desc = "Search partial word (forward)",
	})
	keymap.set("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], {
		desc = "Search partial word (backward)",
	})
end

-- Plugin: flash.nvim (lua/plugins/flash.lua)
function M.flash()
	keymap.set({ "n", "x", "o" }, "S", function()
		require("flash").treesitter()
	end, { desc = "Flash Treesitter" })

	keymap.set({ "o" }, "r", function()
		require("flash").remote()
	end, { desc = "Remote Flash" })

	keymap.set({ "o", "x" }, "R", function()
		require("flash").treesitter_search()
	end, { desc = "Treesitter Search" })

	keymap.set({ "c" }, "<c-s>", function()
		require("flash").toggle()
	end, { desc = "Toggle Flash Search" })
end

-- Plugin: gitsigns.nvim (lua/plugins/gitsigns.lua)
function M.gitsigns(bufnr, gs)
	gs = gs or package.loaded.gitsigns
	keymap.buf(bufnr, "n", "]c", gs.next_hunk, { desc = "Next hunk" })
	keymap.buf(bufnr, "n", "[c", gs.prev_hunk, { desc = "Prev hunk" })
	keymap.buf(bufnr, "n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
	keymap.buf(bufnr, "n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
	keymap.buf(bufnr, "n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
	keymap.buf(bufnr, "n", "<leader>hb", gs.blame_line, { desc = "Blame line" })
end

-- Plugin: fzf-lua (lua/plugins/fzf-lua.lua)
function M.fzf_lua()
	keymap.set("n", "<leader>fa", require("fzf-lua").files, { desc = "[F]zf [A]ppend" })
	keymap.set("n", "<leader>ff", require("fzf-lua").buffers, { desc = "[F]z[F] buffer list" })
	keymap.set("n", "<leader>fs", require("fzf-lua").treesitter, { desc = "[F]zf Symbols list" })
	keymap.set({ "n", "v" }, "<leader>ca", require("fzf-lua").lsp_code_actions, { desc = "[C]ode [A]ctions" })
	keymap.set("n", "<leader>fw", require("fzf-lua").live_grep, { desc = "[F]ind [W]ord" })
end

-- Plugin: obsidian.nvim (lua/plugins/obsidian.lua)
function M.obsidian()
	keymap.set("n", "<leader>os", "<Cmd>! ./sync<CR>", { desc = "[O]bsidian [S]ync" })
	keymap.set("n", "<leader>od", "<Cmd>Obsidian dailies<CR>", { desc = "[O]bsidian [D]aily" })
	keymap.set("n", "<leader>ot", "<Cmd>Obsidian template<CR>", { desc = "[O]bsidian [T]emplates" })
	keymap.set("n", "<leader>on", "<Cmd>Obsidian new<CR>", { desc = "[O]bsidian [N]ew Note" })
	keymap.set("n", "<leader>ob", "<Cmd>Obsidian backlinks<CR>", { desc = "[O]bsidian [B]acklinks" })
	keymap.set("n", "<leader>ow", "<Cmd>Obsidian workspace<CR>", { desc = "[O]bsidian [W]orkspace" })
	keymap.set("n", "<leader>fo", "<Cmd>Obsidian search<CR>", { desc = "[F]ind [O]bsidian file" })
	keymap.set("n", "<leader>ft", "<Cmd>Obsidian tags<CR>", { desc = "[F]ind Obsidian [T]ags" })
	keymap.set("n", "<leader>fl", "<Cmd>Obsidian follow_link<CR>", { desc = "[F]ollow Obsidian [L]ink" })
end

-- Plugin: trouble.nvim (lua/plugins/trouble.lua)
function M.trouble()
	keymap.set("n", "<leader>tt", "<Cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>", {
		desc = "[T]rouble [T]oggle (buffer)",
	})
	keymap.set("n", "<leader>tf", "<Cmd>Trouble diagnostics focus=true<CR>", {
		desc = "[T]rouble [F]ocus",
	})
end

-- Plugin: nvim-treesitter-textobjects (lua/plugins/treesitter.lua)
function M.treesitter_textobjects()
	local select_maps = {
		["af"] = "@function.outer",
		["if"] = "@function.inner",
		["ac"] = "@class.outer",
		["ic"] = "@class.inner",
		["aa"] = "@parameter.outer",
		["ia"] = "@parameter.inner",
	}
	for lhs, query in pairs(select_maps) do
		keymap.set({ "x", "o" }, lhs, function()
			require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
		end, { desc = "Select " .. query })
	end

	local move = require("nvim-treesitter-textobjects.move")
	keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
	keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
	keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function start" })
	keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Prev function end" })
	keymap.set({ "n", "x", "o" }, "]C", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class start" })
	keymap.set({ "n", "x", "o" }, "[C", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class start" })
end

return M
