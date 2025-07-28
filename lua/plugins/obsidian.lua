return {
	{
		"rose-pine",
		dep_of = "obsidian",
		ft = "markdown",
		name = "rose-pine",
		after = function()
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#333333" })
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		"ltex_extra.nvim",
		dep_of = "obsidian",
		ft = "markdown",
		after = function()
			local ltex_extra_setup_done = false
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LtexExtraConfig", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and (client.name == "ltex" or client.name == "ltex_plus") and not ltex_extra_setup_done then
						local ok, ltex_extra = pcall(require, "ltex_extra")
						if ok then
							pcall(ltex_extra.setup, {
								load_langs = { "en-US" },
								init_check = true,
								path = vim.fn.expand("~/.local/share/ltex"),
								log_level = "none",
							})
							ltex_extra_setup_done = true
						else
							vim.notify("Failed to load ltex_extra.nvim", vim.log.levels.WARN)
						end
					end
				end,
			})
		end,
	},
	{
		"obsidian",
		ft = "markdown",
		after = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "Second_Brain",
						path = "~/Second_Brain",
						overrides = {
							notes_subdir = "resources/notes",
						},
					},
				},

				-- Disable legacy commands to avoid deprecation warnings
				legacy_commands = false,

				-- Configure picker to use fzf-lua
				picker = {
					name = "fzf-lua",
				},

				templates = {
					folder = "resources/templates",
				},

				daily_notes = {
					-- Optional, if you keep daily notes in a separate directory.
					folder = "./.",
					-- Optional, if you want to change the date format for the ID of daily notes.
					date_format = "%Y-%m-%d",
					-- Optional, if you want to change the date format of the default alias of daily notes.
					alias_format = "%B %-d, %Y",
					-- Optional, default tags to add to each new daily note created.
					default_tags = { "daily-notes" },
					-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
					template = "~/Second_Brain/resources/templates/daily.md",
				},

				-- Quick Notes
				new_notes_location = "notes_subdir",

				note_id_func = function(title)
					-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
					-- In this case a note with the title 'My new note' will be given an ID that looks
					-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
					local suffix = ""
					if title ~= nil then
						-- If title is given, transform it into valid file name.
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						-- If title is nil, just add 4 random uppercase letters to the suffix.
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return tostring(os.time()) .. "-" .. suffix
				end,

				follow_url_func = function(url)
					-- Open the URL in the default web browser.
					-- vim.fn.jobstart({ "open", url }) -- Mac OS
					-- vim.fn.jobstart({"xdg-open", url})  -- linux
					vim.ui.open(url) -- need Neovim 0.10.0+
				end,
			})

			vim.keymap.set("n", "<leader>os", "<Cmd>! ./sync<CR>", { desc = "[O]bsidian [S]ync" })
			vim.keymap.set("n", "<leader>od", "<Cmd>Obsidian dailies<CR>", { desc = "[O]bsidian [D]aily" })
			vim.keymap.set("n", "<leader>ot", "<Cmd>Obsidian template<CR>", { desc = "[O]bsidian [T]emplates" })
			vim.keymap.set("n", "<leader>on", "<Cmd>Obsidian new<CR>", { desc = "[O]bsidian [N]ew Note" })
			vim.keymap.set("n", "<leader>ob", "<Cmd>Obsidian backlinks<CR>", { desc = "[O]bsidian [B]acklinks" })
			vim.keymap.set("n", "<leader>fo", "<Cmd>Obsidian search<CR>", { desc = "[F]ind [O]bsidian file" })
			vim.keymap.set("n", "<leader>ft", "<Cmd>Obsidian tags<CR>", { desc = "[F]ind Obsidian [T]ags" })
		end,
	},
}
