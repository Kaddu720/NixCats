return {
	{
		"obsidian",
		ft = "markdown",
		dep_of = "reld-colorscheme",
		after = function()
			-- Get hostname to determine default workspace order
			local hostname = vim.fn.hostname()
			local is_home = hostname == "Home-Box" or hostname == "Mobile-Box"
			
			local workspaces
			if is_home then
				-- Second_Brain first (default) for home machines
				workspaces = {
					{
						name = "Second_Brain",
						path = "~/Vaults/Second_Brain",
						overrides = {
							daily_notes = {
								template = "~/Vaults/Second_Brain/resources/templates/neovim/daily.md",
							},
						},
					},
					{
						name = "Work_Brain",
						path = "~/Vaults/Work_Brain",
						overrides = {
							daily_notes = {
								template = "~/Vaults/Work_Brain/resources/templates/neovim/daily.md",
							},
						},
					},
				}
			else
				-- Work_Brain first (default) for work machines
				workspaces = {
					{
						name = "Work_Brain",
						path = "~/Vaults/Work_Brain",
						overrides = {
							daily_notes = {
								template = "~/Vaults/Work_Brain/resources/templates/neovim/daily.md",
							},
						},
					},
					{
						name = "Second_Brain",
						path = "/mnt/c/Users/NoahWilson/Vaults/Second_Brain",
						overrides = {
							daily_notes = {
								template = "~/Vaults/Second_Brain/resources/templates/neovim/daily.md",
							},
						},
					},
				}
			end

			require("obsidian").setup({
				workspaces = workspaces,

				notes_subdir = "resources/notes",

				-- Disable legacy commands to avoid deprecation warnings
				legacy_commands = false,

				-- Configure picker to use fzf-lua
				picker = {
					name = "fzf-lua",
				},

				templates = {
					folder = "resources/templates/neovim",
				},

				daily_notes = {
					-- Optional, if you keep daily notes in a separate directory.
					folder = "./logs/daily/",
					-- Optional, if you want to change the date format for the ID of daily notes.
					date_format = "%Y-%m-%d",
					-- Optional, if you want to change the date format of the default alias of daily notes.
					alias_format = "%B %-d, %Y",
					-- Optional, default tags to add to each new daily note created.
					default_tags = { "daily-notes" },
				},

				-- Quick Notes
				new_notes_location = "notes_subdir",

				note_id_func = function(title)
					-- Create note IDs in a Vaults format with a timestamp and a suffix.
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

				-- follow_url_func removed: vim.ui.open is now the default
			})

			vim.keymap.set("n", "<leader>os", "<Cmd>! ./sync<CR>", { desc = "[O]bsidian [S]ync" })
			vim.keymap.set("n", "<leader>od", "<Cmd>Obsidian dailies<CR>", { desc = "[O]bsidian [D]aily" })
			vim.keymap.set("n", "<leader>ot", "<Cmd>Obsidian template<CR>", { desc = "[O]bsidian [T]emplates" })
			vim.keymap.set("n", "<leader>on", "<Cmd>Obsidian new<CR>", { desc = "[O]bsidian [N]ew Note" })
			vim.keymap.set("n", "<leader>ob", "<Cmd>Obsidian backlinks<CR>", { desc = "[O]bsidian [B]acklinks" })
			vim.keymap.set("n", "<leader>ow", "<Cmd>Obsidian workspace<CR>", { desc = "[O]bsidian [W]orkspace" })
			vim.keymap.set("n", "<leader>fo", "<Cmd>Obsidian search<CR>", { desc = "[F]ind [O]bsidian file" })
			vim.keymap.set("n", "<leader>ft", "<Cmd>Obsidian tags<CR>", { desc = "[F]ind Obsidian [T]ags" })
			vim.keymap.set("n", "<leader>fl", "<Cmd>Obsidian follow_link<CR>", { desc = "[F]ollow Obsidian [L]ink" })
		end,
	},
}
