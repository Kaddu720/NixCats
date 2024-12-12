return {
  {
    "cmp-nvim-lsp",
    on_plugin = { "nvim-cmp" },
    dep_of = { "nvim-lspconfig" },
  },
  {
    "cmp_luasnip",
    on_plugin = { "nvim-cmp" },
    dep_of = { "luasnip" },
  },
  {
    "luasnip",
    on_plugin = { "nvim-cmp" },
    dep_of = { "nvim-cmp" },
    after = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})

      local ls = require("luasnip")

      vim.keymap.set({ "i", "s" }, "<M-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end,
  },
  {
    "nvim-cmp",
    dep_of = { "obsidian.nvim" },
    event = "InsertEnter",
    after = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "treesitter" },
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
