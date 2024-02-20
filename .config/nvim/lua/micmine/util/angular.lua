local M = {};
--- This fuction will return nil if it is not posible to generate there
---@param path string
M.get_angular_path = function(path)
  local current = vim.uv.cwd()
  if current == nil then
    return nil
  end
  -- path must start with current
  if path:find(current, 1, true) then
    -- remove current from path
    path = path:sub(string.len(current) + 1)

    print(path)
    --return nil

     --path must start with "\\src\\app"
    --local prefix = "\\src\\app\\"
    --if path:find(prefix, 1, true) then
      --path = path:sub(string.len(prefix) + 1)
      --return path .. "\\"
    --end
  end
  return nil
end
-- Will return nill if it is not a directory
M.get_directory_node_path = function()
  local lib = require("nvim-tree.lib")
  local node = lib.get_node_at_cursor()
  if node == nil then
    return
  end
  if node.type ~= "directory" then
    return
  end
  return node.absolute_path
end
---@param path string
---@param kind_of_generation string
M.base_generate = function(path, kind_of_generation)
  local angular_path = M.get_angular_path(path)
  if angular_path == nil then
    print("Unable to generate in this folder")
    return
  end
  vim.ui.input({ prompt = "Generate " .. kind_of_generation .. " name: " }, function(user_input)
    local base_command = "npm run ng -- g " .. kind_of_generation .. " " .. angular_path .. user_input
    local cmd = "!" .. base_command
    vim.cmd(cmd)
  end)
end
---@param kind_of_generation string
M.generate = function(kind_of_generation)
  local path = M.get_directory_node_path()
  if path == nil then
    return
  end
  M.base_generate(path, kind_of_generation)
end

return M;
