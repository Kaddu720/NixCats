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

-- page Up and Down Navigation
vim.keymap.set("n", "C-d", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "C-u", "<C-u>zz", { noremap = true, silent = true })

-- Center page when searching
vim.keymap.set("n", "<n>", "<nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "<N>", "<Nzzzv", { noremap = true, silent = true })

-- Traverse soft wrapped lines
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })

-- Yanking from clipboard
vim.api.nvim_set_option("clipboard","unnamed") 
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { noremap = true, silent = true, desc = "[p]aste from clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { noremap = true, silent = true, desc = "[P]aste from clipboard" })

-- Turn of Highlights
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { noremap = true })
