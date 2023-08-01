return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  keys = {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
    },
    {
      "<F4>",
      function()
        require("dap").step_over()
      end,
    },
    {
      "<F3>",
      function()
        require("dap").step_into()
      end,
    },
    {
      "<F2>",
      function()
        require("dap").step_out()
      end,
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
    },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
    },
    {
      "<leader>dlp",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end,
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.open()
      end,
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
    },
    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
    },
    {
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
    },
  },
  config = function()
    local dap = require("dap")

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb", -- adjust as needed, must be absolute path
        args = { "--port", "${port}" },
        -- On windows you may have to uncomment this:
        -- detached = false,
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    local dap_ui = require("dapui")
    dap_ui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dap_ui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dap_ui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dap_ui.close()
    end
  end,
}
