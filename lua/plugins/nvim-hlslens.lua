return {
  "nvim-hlslens",
  keys = {
    {"/", mode = "n", desc = "Search of text" },
    {"*", mode = "n", desc = "Serch for whole hovered word decending" },
    {"#", mode = "n", desc = "Serch for whole hovered word decending" },
    {"g*", mode = "n", desc = "Serch for any match decending" },
    {"g#", mode = "n", desc = "Serch for any match decending" },
    },
  after = function()
    require("hlslens").setup()

    local kopts = { noremap = true, silent = true }

    vim.api.nvim_set_keymap(
      "n",
      "n",
      [[<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts
    )
    vim.api.nvim_set_keymap(
      "n",
      "N",
      [[<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts
    )
    vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
  end,
}
