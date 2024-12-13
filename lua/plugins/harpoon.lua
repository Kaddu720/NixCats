return {
  "harpoon",
  event = "DeferredUIEnter",
  after = function()
    require("harpoon").setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        mark_branch = true,
      }
    })

    vim.keymap.set("n", "<leader>ha", function()
      require("harpoon.mark").add_file()
    end)
    vim.keymap.set("n", "<leader>hh", function()
      require("harpoon.ui").toggle_quick_menu()
    end)

    vim.keymap.set("n", "<leader>h1", function()
      require("harpoon.ui").nav_file(1) -- navigates to file 1
    end)
    vim.keymap.set("n", "<leader>h2", function()
      require("harpoon.ui").nav_file(2) -- navigates to file 2
    end)
    vim.keymap.set("n", "<leader>h3", function()
      require("harpoon.ui").nav_file(3) -- navigates to file 3
    end)
    vim.keymap.set("n", "<leader>h4", function()
      require("harpoon.ui").nav_file(4) -- navigates to file 4
    end)
  end,
}
