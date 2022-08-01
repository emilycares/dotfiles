local common = require("micmine.util.common")
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

local toggle_list = function (items)
  local count = table.getn(items);
  if count then
    if count == 0 then
      vim.api.nvim_command("cclose")
    else
      vim.api.nvim_command("copen")
    end
  end
end

local set_bacon_qfl = function ()
  local files = get_bacon_files()

  if files == {} then
  else
    local items = get_bacon_items(files)

    vim.fn.setqflist({}, ' ', {items = items})

    toggle_list(items)
  end
end

local get_logana_items = function (content)
  if content == nil then
    return {}
  end

  local result = {}

  for line in content:gmatch("([^\r\n]*)[\r\n]?") do
    if line == "" then
    else
      local message = vim.split(line, "|")

      local location = message[1]
      local split_location = vim.split(location, ":")
      local path = split_location[1]
      local row = split_location[2]
      local col = split_location[3]

      table.insert(result, {
        filename = path,
        lnum = row,
        col = col,
        text = message[2]
      })
    end
  end

  return result
end

local set_logana_qfl = function (data)
  local items = get_logana_items(data)

  P(items)

  vim.fn.setqflist({}, ' ', {items = items})

  toggle_list(items)
end


local file_exists = function (name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end



M.set_qfl = function ()
  if file_exists(".bacon-locations") then
    set_bacon_qfl()
  end

  if file_exists(".logana-report") then
    local file_content = get_file_content(".logana-report")
    if file_content then
      set_logana_qfl(file_content)
    end
  else
    if file_exists("pom.xml") then
      vim.fn.jobstart(
      {"cb", "clean", "install"},
      { stdout_buffered = true, on_stdout = function (_, data)
        if data then
          -- open split
          vim.cmd('vsplit')
          local win = vim.api.nvim_get_current_win()
          local buf = vim.api.nvim_create_buf(true, true)
          vim.api.nvim_win_set_buf(win, buf)
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, data);
          -- convert data to string
          local string_data = "";
          for _, v in pairs(data) do
            string_data = string_data .. v .. "\n";
          end
          -- call logana
        end
      end
    })
  end
end
end

common.map(
"<leader>im",
function ()
  local file_data = vim.api.nvim_buf_get_lines(0, 0, -1, false);
          local string_data = "";
          for _, v in pairs(file_data) do
            string_data = string_data .. v .. "\n";
          end
  vim.fn.jobstart({vim.fs.normalize("~/Documents/rust/logana/target/debug/logana")},
  { stdout_buffered = true, stdin = string_data,
  on_stdout = function (_, logana_data)
    if logana_data then
      set_logana_qfl(logana_data:gmatch("([^\r\n]*)[\r\n]?"))
    end
  end
})
end)

return M
