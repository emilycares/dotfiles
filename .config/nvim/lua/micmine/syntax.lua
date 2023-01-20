local auto_group = vim.api.nvim_create_augroup("FROMAT", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  command = "PrettierAsync",
  pattern = "*.ts,*.js,*.json,*.html,*.vue,*.svelte",
  group = auto_group,
})

-- common.map("<leader>f", ":Autoformat<CR>")
