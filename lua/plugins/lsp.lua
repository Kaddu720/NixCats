local servers = {}
servers.lua_ls = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using
      -- (most likely LuaJIT in the case of Neovim)
      version = "LuaJIT",
    },
    formatters = {
      ignoreComments = false,
    },
    signatureHelp = { enabled = true },
    diagnostics = {
      disable = { "missing-fields" },
      -- Get the language server to recognize the `vim` global
      globals = {
        "vim",
        "require",
      },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
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
servers.nil_ls = {}

-- Python
servers.pyright = {}
servers.ruff = {}

-- Markdown
servers.marksman = {}

-- Terraform
servers.terraformls = {}

return {
  {
    "nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    after = function()
      for server_name, config in pairs(servers) do
        require("lspconfig")[server_name].setup({
          capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities),
          settings = config,
          filetypes = (config or {}).filetypes,
          cmd = (config or {}).cmd,
          root_pattern = (config or {}).root_pattern,
        })
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Code" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
    end,
  },
}
