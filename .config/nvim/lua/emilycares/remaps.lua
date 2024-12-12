-- paste but keep same thing copyed
vim.keymap.set("x", "<M-p>", "\"_dP", { noremap = true })

-- replace
vim.keymap.set("n", "<leader>r", ":%s//gI<Left><Left><Left>", { noremap = true })
vim.keymap.set("v", "<leader>r", ":s//g<Left><Left>", { noremap = true })

-- disable zig autoformat
vim.g.zig_fmt_autosave = 0

-- quickfix map - and center
vim.keymap.set("n", "<C-k>", ":cprevious<CR>zzzv");
vim.keymap.set("n", "<C-j>", ":cnext<CR>zzzv");
vim.keymap.set("n", "<leader>k", ":lprevious<CR>zzzv");
vim.keymap.set("n", "<leader>j", ":lnext<CR>zzzv");

-- line move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv");
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv");
vim.keymap.set("v", "<", "<gv");
vim.keymap.set("v", ">", ">gv");

-- center search
vim.keymap.set("n", "n", "nzzzv");
vim.keymap.set("n", "N", "Nzzzv");
vim.keymap.set("n", "J", "mzJ`z");

-- exit terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- spellcheck
vim.keymap.set("n", "<leader><F6>g", ":setlocal spell spelllang=de_ch<CR>");
vim.keymap.set("n", "<leader><F6>e", ":setlocal spell spelllang=en_us<CR>");
