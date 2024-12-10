return {
  "oil.nvim",
  -- equivlent of VeryLazy in lazy.nvim
  event = "DeferredUIEnter",
  after = function()
    require("oil").setup()
    vim.keymap.set("n", '-', "<Cmd>Oil --float<CR>", {})
  end
}
