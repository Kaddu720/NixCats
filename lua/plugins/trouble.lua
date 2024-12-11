return {
  "trouble.nvim",
  event = "DeferredUIEnter",
  after = function()
    local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = "lualine_c_normal",
    })
    -- table.insert(opts.sections.lualine_c, {
    --   symbols.get,
    --   cond = symbols.has,
    -- })
    vim.keymap.set("n", "<leader>tt", '<Cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>', { desc = "[T]rouble [T]oggle" })
    vim.keymap.set("n", "<leader>tf", '<Cmd>Trouble diagnostics focus=true<CR>', { desc = "[T]rouble [F]ocus" })
  end,
}
