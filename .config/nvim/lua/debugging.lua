local M = {}
local common = require("util.common")
local dap = require("dap")
local dap_ui = require("dapui")

dap_ui.setup({})

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

dap.listeners.after.event_initialized["dapui_config"] = function()
  dap_ui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dap_ui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dap_ui.close()
end

common.map("<leader>dc", dap.continue)
common.map("<F10>", dap.step_over)
common.map("<F11>", dap.step_into)
common.map("<F12>", dap.step_out)
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
