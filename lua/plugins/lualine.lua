return {
  "lualine.nvim",
  after = function()
    local custom_rosepine = require('lualine.themes.rose-pine')
    custom_rosepine.normal.c.bg = 'None'
    custom_rosepine.insert.c.bg = 'None'
    custom_rosepine.command.c.bg = 'None'
    require('lualine').setup { options = { theme = custom_rosepine}}
  end
}
