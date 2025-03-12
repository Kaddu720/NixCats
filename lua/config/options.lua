vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Indent
vim.o.expandtab = true -- convert tabs to spaces
vim.o.tabstop = 2      -- tab shifts 2 spaces
vim.o.softtabstop = 2
vim.o.shiftwidth = 2   -- make shift in vidual mode worth 2 spaces
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- Searching
vim.opt.hlsearch = true      -- highlight search results
vim.opt.incsearch = true     -- highlight objects as you search for them
vim.o.ignorecase = true      -- ignore case when Searching
vim.o.smartcase = true       -- case matters if I use capital letters
vim.opt.inccommand = "split" -- give an preview of commands before they are executed

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Appearence
vim.opt.scrolloff = 10   -- minum number of lines abobe/bellow cursor
vim.opt.showmode = false -- let lualine provide status
vim.opt.conceallevel = 2 -- let obsidan conceal test with ui

vim.opt.swapfile = false -- don't use swapfiles

-- Language Specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.opt_local.cursorcolumn = true -- Highlight the current column
    vim.opt_local.shiftwidth = 2    -- Number of spaces to use for each step of (auto)indent
    vim.opt_local.softtabstop = 2   -- Number of spaces that a <Tab> counts for while performing editing operations
    vim.opt_local.tabstop = 2       -- Number of spaces that a <Tab> in the file counts for
    vim.opt_local.expandtab = true  -- Expand tab to 2 spaces
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>yl", ":!yamllint %<CR>", { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})
