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

