return {
  {
    "fzf-lua",
    keys = {
      { "<leader>fa", mode = "n", desc = "[F]zf [A]ppend" },
      { "<leader>ff", mode = "n", desc = "[F]z[F] buffer list" },
      { "<leader>ca", mode = { "n", "v" }, desc = "[C]ode [A]ctions" },
      { "<leader>fw", mode = "n", desc = "[F]ind [W]ord" },
    },
    after = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
      require('fzf-lua').register_ui_select()

      vim.keymap.set("n", "<leader>fa", function()
        vim.cmd("wal")
        require("fzf-lua").files()
      end, { desc = "[F]zf [A]ppend" })

      vim.keymap.set("n", "<leader>ff", function()
        vim.cmd("wal")
        require("fzf-lua").buffers()
      end, { desc = "[F]z[F] buffer list" })

      vim.keymap.set({ "n", "v" }, "<leader>ca", function()
        vim.cmd("wal")
        require("fzf-lua").lsp_code_actions()
      end, { desc = "[C]ode [A]ctions" })

      -- Don't forget. If you hit C-g you can fuzzy search over your grep
      vim.keymap.set("n", "<leader>fw", function()
        vim.cmd("wal")
        require("fzf-lua").live_grep()
      end, { desc = "[F]ind [W]ord" })

    end,
  },
}
