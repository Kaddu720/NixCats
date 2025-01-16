return {
  "snacks.nvim",
  lazy = false,
  after = function()
    require("snacks").setup({
      scroll = { enabled = true },
      indent = {
        enabled = true, -- enable indent guides
        only_scope = true,
        only_current = true,
        animate = { enabled = false },
      },
      scope = { enabled = true },
    })

    vim.keymap.set("n", "<leader>l", function()
      Snacks.lazygit.open()
    end, { desc = "[L]azygit" })
  end,
}
