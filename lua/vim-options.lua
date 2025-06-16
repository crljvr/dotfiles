vim.g.mapleader = " "

-- Fat Cursor
vim.opt.guicursor = ""

-- Line Numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Nicer Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Keep 8 Lines Visible When Scrolling
vim.opt.scrolloff = 8

-- Update Time?
vim.opt.updatetime = 50

-- Since Team Wants 80 Chars...
vim.opt.colorcolumn = "80"

-- Override Jump Half A Page
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Indenting in Flutter
vim.filetype.add({
  extension = { dart = "dart" },
})
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
