return {
  "avante.nvim",
  event = "DeferredUIEnter",
  version = false, -- Never set this value to "*"
  after = function ()
    require("avante").setup({})
  end
}
