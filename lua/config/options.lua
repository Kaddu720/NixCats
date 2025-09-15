-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Indent
vim.o.expandtab = true -- convert tabs to spaces
vim.o.tabstop = 2 -- tab shifts 2 spaces
vim.o.softtabstop = 2
vim.o.shiftwidth = 2 -- make shift in vidual mode worth 2 spaces
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- Searching
vim.opt.hlsearch = true -- highlight search results
vim.opt.incsearch = true -- highlight objects as you search for them
vim.o.ignorecase = true -- ignore case when Searching
vim.o.smartcase = true -- case matters if I use capital letters
vim.opt.inccommand = "split" -- give an preview of commands before they are executed

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Appearence
vim.opt.scrolloff = 10 -- minum number of lines abobve/bellow cursor
vim.opt.conceallevel = 2 -- let obsidan conceal test with ui
vim.opt.clipboard = "unnamedplus" -- system clipboard integration
vim.opt.mouse = "a" -- mouse support
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.cursorline = true -- highlight current line

-- Diagnostics
vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})

-- Performance options
vim.opt.lazyredraw = true -- don't redraw screen during macros
vim.opt.hidden = true -- allow switching buffers without saving
vim.g.startup_time_enabled = true -- enable startup time measurement
vim.opt.history = 100 -- limit command history
vim.opt.synmaxcol = 120 -- Performance: Reduced from 240 for faster syntax highlighting
vim.opt.redrawtime = 1500 -- time limit for syntax highlighting
vim.opt.ttyfast = true -- faster terminal rendering
vim.opt.swapfile = false -- don't use swapfiles
vim.opt.updatetime = 250 -- Performance: Increased from 100ms for better performance
vim.opt.timeout = true
vim.opt.timeoutlen = 300 -- faster timeout for keymaps
vim.opt.ttimeoutlen = 10 -- faster timeout for terminal keys
vim.opt.maxmempattern = 1000 -- Performance: Limit memory usage for patterns
vim.opt.undolevels = 100 -- Performance: Limit undo history for memory
vim.g.loaded_netrw = 1 -- Disable default Netrw if you use another file explorer
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchparen = 1-- Disable MatchParen if you use a Treesitter-based highlighter
vim.g.loaded_matchit = 1



-- Enable autoread to detect external changes
vim.opt.autoread = true

-- Autocmd to check for file changes when events occur
vim.api.nvim_create_autocmd(
  { "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" },
  {
    pattern = "*",
    callback = function()
      if vim.fn.mode() ~= "c" then
        vim.cmd("checktime")
      end
    end,
  }
)

-- Optional: Notify when a file was reloaded due to external change
vim.api.nvim_create_autocmd(
  "FileChangedShellPost",
  {
    pattern = "*",
    callback = function()
      vim.api.nvim_echo({{"File changed on disk. Buffer reloaded.", "WarningMsg"}}, false, {})
    end,
  }
)

