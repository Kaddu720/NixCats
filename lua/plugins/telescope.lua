return {
  {
    "telescope-ui-select.nvim",
    on_plugin = "telescope.nvim",
    tles,
  },
  {
    "telescope-fzf-native.nvim",
    on_plugin = "telescope.nvim",
  },
  {
    "telescope.nvim",
    event = "DeferredUIEnter",
    after = function()
      local builtin = require("telescope.builtin")

      -- vim.keymap.set("n", "<leader>ff", function()
      --   vim.cmd("wal")
      --   builtin.find_files()
      -- end, { desc = "[F]ind [F]ile" })
      --
      -- vim.keymap.set("n", "<leader>fw", function()
      --   vim.cmd("wal")
      --   builtin.live_grep()
      -- end, { desc = "[F]ind [W]ord" })
      --
      -- vim.keymap.set("n", "<leader>fb", function()
      --   vim.cmd("wal")
      --   builtin.buffers()
      -- end, { desc = "[F]ind [B]uffers" })
      --
      -- require("telescope").setup({
      --   extensions = {
      --     ["ui-select"] = {
      --       require("telescope.themes").get_dropdown({}),
      --     },
      --   },
      -- })
      -- require("telescope").load_extension("ui-select")
      -- require("telescope").load_extension("fzf")
    end,
  },
  {
    "fzf-lua",
    -- optional for icon support
    after = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})

      vim.keymap.set("n", "<leader>ff", function()
        vim.cmd("wal")
        require('fzf-lua').files()
      end, { desc = "[F]ind [F]ile" })

      vim.keymap.set("n", "<leader>fw", function()
        vim.cmd("wal")
        require('fzf-lua').grep()
      end, { desc = "[F]ind [W]ord" })
    end,
  },
}
