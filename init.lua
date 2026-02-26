vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.have_nerd_font = true
vim.opt.mouse = "a"
-- vim.opt.showmode = false -- Turn on after we will add statusline

-- Only after entering as it might increase start time
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.cmd([[colorscheme catppuccin]])

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.pack.add({
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/tpope/vim-fugitive",
})

require("mini.icons").setup()
local wk = require("which-key")
wk.setup({
	preset = "helix",
})
wk.add({
  { "<leader>f", group = "[f]zf" , icon = "", mode = { "n", "v" }},
})

require("fzf-lua").setup({ fzf_colors = true })
local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Fzf live grep" })
vim.keymap.set("n", "<leader>fb", fzf.builtin, { desc = "Fzf Builtin Picker" })
