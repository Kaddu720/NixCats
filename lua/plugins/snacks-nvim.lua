return {
  "snacks.nvim",
  lazy = false,
  after = function()
    require("snacks").setup({
      indent = {
        enabled = true, -- enable indent guides
        only_scope = true,
        only_current = true,
        animate = { enabled = false },
      },
      scope = { enabled = true },
    })
  end,
}
