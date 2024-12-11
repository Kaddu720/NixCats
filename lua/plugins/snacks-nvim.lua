return {
  "snacks.nvim",
  lazy = false,
  after = function()
    require("snacks").setup({
      opts = {
        lazygit = {
          enabled = true,
          configure = true,
        },
      },
    })
  end,
}
