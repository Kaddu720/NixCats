return {
  "avante.nvim",
  keys = {
    { "<leader>aa", mode = "n", desc = "[A]vante [A]sk" },
    { "<leader>at", mode = "n", desc = "[A]vante [T]oggle" },
  },
  version = false, -- Never set this value to "*"
  after = function ()
    require("avante").setup({})
  end
}
