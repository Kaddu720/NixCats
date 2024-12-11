return {
  "neo-tree.nvim",
  event = "DeferredUIEnter",
  after = function()
    vim.keymap.set("n", "<leader>ee", "<Cmd>Neotree toggle<CR>", { desc = "Toggle Neotree" })
    vim.keymap.set("n", "<leader>ef", "<Cmd>Neotree filesystem reveal left<CR>", { desc = "Toggle Neotree on current location" })
  end,
}
