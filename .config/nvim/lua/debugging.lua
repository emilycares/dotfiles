local M = {}
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

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set("n", "<leader>dlp", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set("n", "<leader>dl", dap.run_last)
vim.keymap.set("n", "<leader>du", dap_ui.toggle)


return M
