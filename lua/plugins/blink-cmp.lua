return {
  {
    "luasnip",
    dep_of = { "blink-cmp" },
    on_plugin = { "blink-cmp" },
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
        -- luasnip
        snippets = {
          expand = function(snippet)
            require("luasnip").lsp_expand(snippet)
          end,
          active = function(filter)
            if filter and filter.direction then
              return require("luasnip").jumpable(filter.direction)
            end
            return require("luasnip").in_snippet()
          end,
          jump = function(direction)
            require("luasnip").jump(direction)
          end,
        },
        sources = {
          default = { "lsp", "path", "luasnip", "buffer" },
        },
      })
    end,
  },
}
