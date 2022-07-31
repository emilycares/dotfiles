local M = {}
local get_file_content = function (path)
  local f = io.open(path, "rb")
  if f == nil then
    return nil
  end

  local content = f:read("*all")
  f:close()
  return content
end

local get_bacon_files = function ()
  local content = get_file_content(".bacon-locations")
  if content == nil then
    print("Could not fild file .bacon-locations")
    return {}
  end

  local result = {}

  for line in content:gmatch("([^\r\n]*)[\r\n]?") do
    if line == "" then
    else
      local file = vim.split(line, " ")[2];

      table.insert(result, file)
    end
  end

  return result
end

local get_bacon_items = function (files)
  local result = {}
  for _, v in pairs(files) do
    local split_line = vim.split(v, ":")
    local path = split_line[1]
    local row = split_line[2]
    local col = split_line[3]

    local file = {
      filename = path,
      lnum = row,
      col = col
    };

    table.insert(result, file)
  end

  return result
end

M.set_bacon_qfl = function ()
  local files = get_bacon_files()

  if files == {} then
  else
    local items = get_bacon_items(files)

    vim.fn.setqflist({}, ' ', {items = items})

    if table.getn(items) == 0 then
      vim.api.nvim_command("cclose")
    else
      vim.api.nvim_command("copen")
    end
  end
end

return M
