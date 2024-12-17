return {
  {
    "fzf-lua",
    event = "DeferredUIEnter",
    -- optional for icon support
    after = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})

      vim.keymap.set("n", "<leader>ff", function()
        vim.cmd("wal")
        require("fzf-lua").files()
      end, { desc = "[F]ind [F]ile" })

      vim.keymap.set("n", "<leader>fw", function()
        vim.cmd("wal")
        require("fzf-lua").live_grep()
      end, { desc = "[F]ind [W]ord" })
    end,
  },
}
