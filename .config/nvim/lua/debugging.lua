local M = {};
local dap = require('dap');

dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/tools/vscode-firefox-debug/dist/adapter.bundle.js'},
}

dap.configurations.typescript = {{
  name = 'Debug with Firefox',
  type = 'firefox',
  request = 'launch',
  reAttach = true,
  url = 'http://localhost:4200',
  webRoot = '${workspaceFolder}',
  firefoxExecutable = '/usr/bin/firefox'}
}

M.js_executor = function (type)
  for v in pairs(dap.configurations) do
    v.type = type;
    v.name = 'Debug with ' + type;
  end
end

return M;
