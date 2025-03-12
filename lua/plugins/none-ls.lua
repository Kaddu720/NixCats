return {
  "none-ls.nvim",
  event = "DeferredUIEnter",
  after = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- lua
        null_ls.builtins.formatting.stylua,

        -- python
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.mypy,

        -- nix
        null_ls.builtins.formatting.alejandra,
        null_ls.builtins.diagnostics.deadnix,

        -- yaml
        null_ls.builtins.formatting.prettier,
      },
    })

    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = '[F]or[M]at'})
  end,
}
