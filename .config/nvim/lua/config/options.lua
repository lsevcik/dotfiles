-- Globals
vim.g.mapleader = ","

-- General Settings
vim.opt.title = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.opt.clipboard:append('unnamedplus')
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Set listchars
vim.opt.listchars = { tab = '»»', trail = '×', nbsp = '~' }
vim.opt.list = true

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Search settings
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wildmode = { 'longest', 'list', 'full' }

-- Diff highlighting
if vim.opt.diff:get() then
    vim.api.nvim_set_hl(0, 'DiffText', { link = 'MatchParen' })
end

-- Fold settings
vim.opt.foldminlines = 5
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
