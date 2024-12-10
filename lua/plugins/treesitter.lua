return {
  "nvim-treesitter",
  -- event = VeryLazy
  event = "DeferredUIEnter",
  after = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "lua",
        "nix",
        "python",
        "markdown",
        "markdown_inline",
        "terraform",
        "vim",
        "bash",
        "json",
        "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
