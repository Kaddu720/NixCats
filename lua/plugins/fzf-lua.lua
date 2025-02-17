return {
  {
    "fzf-lua",
    event = "DeferredUIEnter",
    -- optional for icon support
    after = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})

      vim.keymap.set("n", "fa", function()
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

      -- Don't forget. If you hist C-g you can fuzzy search over your grep
      vim.keymap.set("n", "<leader>fw", function()
        vim.cmd("wal")
        require("fzf-lua").live_grep()
      end, { desc = "[F]ind [W]ord" })
    end,
  },
}
