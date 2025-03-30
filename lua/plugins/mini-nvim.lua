return {
  "mini.nvim",
  event = "DeferredUIEnter",
  after = function ()
    require('mini.surround').setup()
  end
}
