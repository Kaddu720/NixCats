return {
  "obsidian.nvim",
  event = "DeferredUIEnter",
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

    vim.keymap.set("n", "<leader>ot", "<Cmd>ObsidianTemplates<CR>", { desc = "[O]bsidian [T]emplates" })
    vim.keymap.set("n", "<leader>os", "<Cmd>! ./sync<CR>", { desc = "[O]bsidian [S]ync" })
    vim.keymap.set("n", "<leader>od", "<Cmd>ObsidianDailies<CR>", { desc = "[O]bsidian [D]aily" })
  end,
}
