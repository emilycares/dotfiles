local conf = require("telescope.config").values
local pickers = require("telescope.pickers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local utils = require("telescope.previewers.utils")
local plenary = require("plenary")

local M = {}

---@param command string
---@param args string[]
---@return string[]
M._run_command = function(command, args)
  local job_opts = {
    command = command,
    args = args,
  }
  local job = plenary.job:new(job_opts):sync()[1]
  local parsed = vim.json.decode(job);
  if parsed then
    return parsed
  end
  return {}
end

-- setup quarkus find routes with https://github.com/micmine/qute-lsp
M.routes = function(opts)
  pickers
    .new(opts, {
      finder = finders.new_dynamic({
        fn = function()
          return M._run_command("qute-lsp", { "--get-routes" })
        end,

        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.path .. " " .. entry.method,
            ordinal = entry.path .. " " .. entry.method,
          }
        end,
      }),

      sorter = conf.generic_sorter(opts),

      previewer = previewers.new_buffer_previewer({
        title = "Quarkus Route",
        define_preview = function(self, entry)
          local formatted = {
            "# " .. entry.value.path,
            "Method: " .. entry.value.method,
            "Produces: " .. entry.value.produces_type,
          }
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true, formatted)
          utils.highlighter(self.state.bufnr, "markdown")
        end,
      }),

      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          local uri = selection.value.implementation.uri
          uri = uri:sub(8, uri.length)
          local folder = vim.fn.getcwd()
          if vim.startswith(uri, folder) then
            local folder_len = folder:len() + 2
            uri = uri:sub(folder_len, uri.length)
          end

          local command = {
            "edit",
            uri,
          }
          local pos = selection.value.implementation.range.start
          vim.cmd(vim.fn.join(command, " "))
          vim.api.nvim_win_set_cursor(0, { pos.line + 1, pos.character + 1 })
        end)
        return true
      end,
    })
    :find()
end

vim.api.nvim_create_user_command("QuarkusRoutes", function()
  M.routes()
end, {})

return M
