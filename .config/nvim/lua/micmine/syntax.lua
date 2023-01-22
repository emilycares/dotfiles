local auto_group = vim.api.nvim_create_augroup("FROMAT", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  command = "Format",
  pattern = "*.ts,*.js,*.json,*.html,*.vue,*.svelte",
  group = auto_group,
})
