return {
  "obsidian.nvim",
  event = "InsertEnter",
  ft = "markdown",
  after = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "Second_Brain",
          path = "~/Second_Brain",
          overrides = {
            notes_subdir = "resources/reference/notes",
          },
        },
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
    vim.keymap.set("n", "<leader>od", "<Cmd>ObsidianDailies<CR>", { desc = "[O]bsidian [D]aily" })
    vim.keymap.set("n", "<leader>ot", "<Cmd>ObsidianTemplate<CR>", { desc = "[O]bsidian [T]emplates" })
    vim.keymap.set("n", "<leader>on", "<Cmd>ObsidianNew<CR>", { desc = "[O]bsidian [N]ew Note" })
    vim.keymap.set("n", "<leader>fo", "<Cmd>ObsidianSearch<CR>", { desc = "[F]ind [O]bsidian file" })
  end,
}
