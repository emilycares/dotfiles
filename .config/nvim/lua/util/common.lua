local M = {}

M.map = function(map, fln)
    local args = {silent = true}
    vim.keymap.set("n", map, fln, args)
end

M.mapb = function(map, fln)
    local args = {buffer = 0, silent = true}
    vim.keymap.set("n", map, fln, args)
end

return M
