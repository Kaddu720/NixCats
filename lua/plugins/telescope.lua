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
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = '[F]ind [F]ile'})
      vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = '[F]ind [W]ord'})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = '[F]ind [B]uffer'})
      vim.keymap.set("n", "<leader>fh", '<Cmd>Telescope harpoon marks<CR>', { desc = '[F]ind [H]arpoon'})

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
