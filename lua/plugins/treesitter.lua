return {
  "nvim-treesitter",
  event = "BufRead",
  after = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
