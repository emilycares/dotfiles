local M = {}

P = function(v)
  print(vim.inspect(v))
  return v
end


M.map = function(map, fln)
  local args = { noremap = true, silent = true }
  vim.keymap.set("n", map, fln, args)
end

M.mapb = function(map, fln, bufnr)
  local args = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", map, fln, args)
end

return M
