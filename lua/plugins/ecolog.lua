return {
  "ecolog",
  -- lazy loading is done internally
  lazy = false,
  after = function()
    require("ecolog").setup({
      integrations = {
        -- If you are planning to use blink cmp uncomment this line
        blink_cmp = true,
        lsp = true,
      },
      -- Enables shelter mode for sensitive values
      shelter = {
        configuration = {
          partial_mode = false, -- false by default, disables partial mode, for more control check out shelter partial mode
          mask_char = "*", -- Character used for masking
        },
        modules = {
          cmp = true,   -- Mask values in completion
          peek = false, -- Mask values in peek view
          files = false, -- Mask values in files
          telescope = false, -- Mask values in telescope
        },
      },
      -- true by default, enables built-in types (database_url, url, etc.)
      types = true,
      path = vim.fn.getcwd(),             -- Path to search for .env files
      preferred_environment = "development", -- Optional: prioritize specific env files
    })
  end,
}
