return { 
  "rose-pine", 
  lazy = false,
  name="rose-pine",
  after = function()
    require("rose-pine").setup({
      styles = {
        transparency = true,
      }
    })
    vim.cmd.colorscheme "rose-pine"
  end
}
