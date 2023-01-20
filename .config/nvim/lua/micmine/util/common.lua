local M = {}

P = function(v)
  print(vim.inspect(v))
  return v
end

vim.keymap.set("n", "<leader><leader>x", function()
  vim.api.nvim_command("write")
  vim.api.nvim_command("source %")
end)

M.map = function(map, fln)
  local args = { noremap = true, silent = true }
  vim.keymap.set("n", map, fln, args)
end

M.mapb = function(map, fln, bufnr)
  local args = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", map, fln, args)
end

return M
