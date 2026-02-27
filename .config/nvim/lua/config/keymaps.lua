local opts = { noremap = true, silent = true }

-- Diagnostic mappings
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- Don't use clipboard for change motion
vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("n", "C", '"_C', { noremap = true })

-- Rerun commands over visual selection
vim.keymap.set("v", ".", ":normal .<CR>", { noremap = true })

-- Split navigation
vim.keymap.set("", "<C-h>", "<C-w>h")
vim.keymap.set("", "<C-j>", "<C-w>j")
vim.keymap.set("", "<C-k>", "<C-w>k")
vim.keymap.set("", "<C-l>", "<C-w>l")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n>")

--
vim.keymap.set({ "n", "v" }, "Q", "gq", { noremap = true })
vim.keymap.set("n", "S", ":%s//g<Left><Left>", { noremap = true })
vim.keymap.set("n", "<leader>o", ":setlocal spell! spelllang=en_us<CR>", { noremap = true })
vim.keymap.set("n", "<leader>p", ":!open <c-r>%<CR><CR>", { noremap = true })
vim.keymap.set("n", "<leader>w", ":setlocal wrap!<Enter>", { noremap = true })
vim.keymap.set("n", "<Esc><Esc>", ":noh<Enter>", { noremap = true })

-- Sudo write
vim.keymap.set("c", "w!!", "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!", { noremap = true })
