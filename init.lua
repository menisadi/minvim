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

vim.api.nvim_create_user_command("PackUpdate", function() vim.pack.update() end, {})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.pack.add({
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/Saghen/blink.cmp",
	"https://github.com/stevearc/aerial.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/stevearc/conform.nvim",
})

local wk = require("which-key")
wk.setup({
	preset = "helix",
})
wk.add({
	{ "<leader>f", group = "[f]zf", icon = "", mode = { "n", "v" } },
	{ "<leader>l", group = "[L]sp", icon = "󰒕", mode = { "n", "v" } },
})

require("fzf-lua").setup({ fzf_colors = true })
local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Fzf live grep" })
vim.keymap.set("n", "<leader>fb", fzf.builtin, { desc = "Fzf Builtin Picker" })

require("oil").setup()
vim.keymap.set("n", "<leader>lO", "<cmd>Oil<cr>", { desc = "Open Oil" })
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

local ts_parsers = {
	"gleam",
	"python",
	"bash",
	"gitcommit",
	"gitignore",
	"json",
	"lua",
	"dockerfile",
	"markdown",
	"sql",
	"toml",
	"yaml",
}
local nts = require("nvim-treesitter")
nts.install(ts_parsers)
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
vim.lsp.config("basedpyright", {
	cmd = { "basedpyright-langserver", "--stdio" },
	settings = {
		analysis = {
			autoSearchPaths = true,
			diagnosticMode = "openFilesOnly",
		},
	},
	filetypes = { "python" },
	root_markers = { { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" }, ".git" },
})
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})
vim.lsp.enable({ "lua_ls", "basedpyright" })
require("blink.cmp").setup({
	fuzzy = { implementation = "lua" },
	keymap = { preset = "default" },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
})

require("conform").setup({
	format_on_save = true,
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff" },
	},
})
vim.keymap.set("n", "<leader>lf", require("conform").format, { desc = "Format buffer" })

require("flash").setup({
	modes = {
		search = {
			enabled = false,
		},
		char = {
			jump_labels = false,
			-- highlight = { backdrop = false, matches = true },
			multi_line = false,
		},
	},
})
vim.keymap.set("n", "s", require("flash").jump, { desc = "Flash jump" })
vim.keymap.set("n", "S", require("flash").treesitter, { desc = "Flash jump" })

require("aerial").setup({
	layout = {
		max_width = { 40, 0.3 },
		default_direction = "prefer_left",
	},
})
vim.keymap.set("n", "<leader>la", "<cmd>AerialToggle<CR>", { desc = "Aerial Toggle" })
