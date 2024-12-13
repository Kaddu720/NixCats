return {
  "snacks",
  lazy = false,
  after = function()
    require("snacks").setup({
      notifier = { enabled = true },
      lazygit = {
        enabled = true,
        configure = false,
        theme = nil,
      },
      indent = {
        enabled = true, -- enable indent guides
        only_scope = true,
        only_current = true,
        animate = { enabled = false },
      },
    })

    vim.keymap.set("n", "<leader>l", function()
      Snacks.lazygit.open()
    end, { desc = "[L]azygit" })
  end,
}
