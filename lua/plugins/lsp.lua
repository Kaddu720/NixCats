local servers = {}
servers.lua_ls = {
  Lua = {
    formatters = {
      ignoreComments = false,
    },
    signatureHelp = { enabled = true },
    diagnostics = {
      disable = { "missing-fields" },
    },
  },
  telemetry = { enabled = false },
  filetypes = { "lua" },
}

-- Nixos
servers.nixd = {
  nixd = {
    formatting = {
      command = { "nil" },
    },
  },
}
-- Python
servers.pyright = {}
servers.ruff = {}

return {
  "nvim-lspconfig",
  lazy = false,
  after = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({
      capabilites = capabilities,
    })
    lspconfig.nixd.setup({
      capabilities = capabilities,
    })
    lspconfig.pyright.setup({
      capabilities = capabilities,
    })
    lspconfig.ruff.setup({
      capabilities = capabilities,
    })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
  end,
}
