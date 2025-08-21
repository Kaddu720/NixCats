-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- page Up and Down Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- -- Center page when searching
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- Traverse soft wrapped lines
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })

-- Turn of Highlights
vim.keymap.set("n", "<C-l>", "<Cmd>noh<CR>", { noremap = true, silent = true })

-- Turn off Virtual line diagnostics
vim.keymap.set('n', 'cd', function()
  -- Get the current diagnostic configuration
  local current_config = vim.diagnostic.config()

  -- Check if virtual_lines is a table and has current_line set to true
  -- If virtual_lines is not a table (i.e., false or nil), current_line_is_on will be false
  local current_line_is_on = type(current_config.virtual_lines) == 'table' and
                             current_config.virtual_lines.current_line == true

  if current_line_is_on then
    -- If current_line is ON, turn OFF all virtual lines
    vim.diagnostic.config({
      virtual_lines = false -- Setting to false disables all virtual lines
    })
  else
    -- If current_line is OFF (or virtual_lines is false/nil), turn ON only the current line virtual line
    vim.diagnostic.config({
      virtual_lines = {
        current_line = true
      }
    })
  end
end, { desc = 'Toggle diagnostic virtual_lines: none vs current_line' })
