return {
  "harpoon",
  event = "DeferredUIEnter",
  after = function()
    require("harpoon").setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        mark_branch = true,
      },
    })

    vim.keymap.set("n", "<leader>ha", function()
      require("harpoon.mark").add_file()
    end, { desc = "[H]arpoon [A]ppend" })
    vim.keymap.set("n", "<leader>hh", function()
      require("harpoon.ui").toggle_quick_menu()
    end, { desc = "[H][H]arpoon Menu Toggle" })

    vim.keymap.set("n", "<leader>h1", function()
      require("harpoon.ui").nav_file(1) -- navigates to file 1
    end, { desc = "[H]arpoon File [1]" })
    vim.keymap.set("n", "<leader>h2", function()
      require("harpoon.ui").nav_file(2) -- navigates to file 2
    end, { desc = "[H]arpoon File [2]" })
    vim.keymap.set("n", "<leader>h3", function()
      require("harpoon.ui").nav_file(3) -- navigates to file 3
    end,{ desc = "[H]arpoon File [3]" } )
    vim.keymap.set("n", "<leader>h4", function()
      require("harpoon.ui").nav_file(4) -- navigates to file 4
    end, { desc = "[H]arpoon File [4]" })
  end,
}
