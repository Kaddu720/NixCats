return {
  {
    "friendly-snippets",
    dep_of = { "blink-cmp" },
  },
  {
    "blink-cmp",
    event = { "InsertEnter" },
    dep_of = { "nvim-lspconfig" },
    after = function()
      require("blink-cmp").setup({
        -- keymap
        keymap = { preset = "enter" },

        -- Styling
        completion = {
          menu = {
            border = "rounded",
            winhighlight = "Normal:None,FloatBorder:BlinkCmpDocBorder,CursorLine:CursorLine,Search:None",
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 50,
            window = {
              border = "rounded",
            },
          },

          list = {
            selection = "auto_insert",
          },
        },
        sources = {
          default = { "lsp", "path", "luasnip", "buffer" },
        },
      })
    end,
  },
}
