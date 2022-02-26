local M = {}

P = function (v)
  print(vim.inspect(v))
  return v
end

-- reload current file
vim.keymap.set("n", "<leader><leader>x", function ()
  vim.api.nvim_command("write")
  vim.api.nvim_command("source %")
end)

M.map = function(map, fln)
    local args = {silent = true}
    vim.keymap.set("n", map, fln, args)
end

M.mapb = function(map, fln)
    local args = {buffer = 0, silent = true}
    vim.keymap.set("n", map, fln, args)
end

return M
