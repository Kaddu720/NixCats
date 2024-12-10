return {
  {
    "telescope-ui-select.nvim",
  },
  {
    "telescope-fzf-native.nvim",
  },
  {
    "telescope.nvim",
    after = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})

      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
      -- require("telescope").load_extension("fzf-native")
    end,
  },
}
