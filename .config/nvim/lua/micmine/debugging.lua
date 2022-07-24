local M = {}
local common = require("micmine.util.common")
local dap = require("dap")
local dap_ui = require("dapui")

dap_ui.setup()
require("nvim-dap-virtual-text").setup()

dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/tools/vscode-firefox-debug/dist/adapter.bundle.js"}
}

dap.configurations.typescript = {
    {
        name = "Debug with Firefox",
        type = "firefox",
        request = "launch",
        reAttach = true,
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        firefoxExecutable = "/usr/bin/firefox"
    }
}

dap.adapters.java = function(callback)
  callback({
    type = 'server';
    host = '127.0.0.1';
    port = 5005;
  })
end

dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
  },
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    --cwd = '${workspaceFolder}',
    cwd = '/home/michael/tmp/mockit/',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}


dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.listeners.after.event_initialized["dapui_config"] = function()
  dap_ui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dap_ui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dap_ui.close()
end

common.map("<F5>", dap.continue)
common.map("<F4>", dap.step_over)
common.map("<F3>", dap.step_into)
common.map("<F2>", dap.step_out)
common.map("<leader>db", dap.toggle_breakpoint)
common.map(
    "<leader>dB",
    function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end
)
common.map(
    "<leader>dlp",
    function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end
)
common.map("<leader>dr", dap.repl.open)
common.map("<leader>dl", dap.run_last)
common.map("<leader>de", dap_ui.eval)
common.map("<leader>du", dap_ui.toggle)

return M
