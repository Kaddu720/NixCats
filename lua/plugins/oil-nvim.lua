return {
  "oil.nvim",
  -- equivlent of VeryLazy in lazy.nvim
  event = "DeferredUIEnter",
  after = function()
    require("oil").setup({
      default_file_explorer = true,
      view_options = {
         show_hidden = true,
      }
    })
    vim.keymap.set("n", "-", "<Cmd>Oil --float<CR>", {})
  end,
}
