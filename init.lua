vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.have_nerd_font = true
vim.opt.mouse = 'a'
-- vim.opt.showmode = false -- Turn on after we will add statusline

-- Only after entering as it might increase start time
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'

