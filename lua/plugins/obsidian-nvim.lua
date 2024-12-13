return {
  "obsidian.nvim",
  event = "InsertEnter",
  ft = "markdown",
  after = function()
    if vim.fn.hostname() == "DTLA-SYSOPS-NW-ML" then
      Name = "WorkBrain"
      Path = "~/WorkBrain"
    else
      Name = "Second_Brain"
      Path = "~/Second_Brain"
    end
    require("obsidian").setup({
      workspaces = {
        {
          name = Name,
          path = Path,
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
        template = "~/WorkBrain/resources/templates/daily.md",
      },

      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        -- vim.fn.jobstart({ "open", url }) -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
        vim.ui.open(url) -- need Neovim 0.10.0+
      end,
    })

    vim.keymap.set("n", "<leader>ot", "<Cmd>ObsidianTemplate<CR>", { desc = "[O]bsidian [T]emplates" })
    vim.keymap.set("n", "<leader>os", "<Cmd>! ./sync<CR>", { desc = "[O]bsidian [S]ync" })
    vim.keymap.set("n", "<leader>od", "<Cmd>ObsidianDailies<CR>", { desc = "[O]bsidian [D]aily" })
  end,
}
