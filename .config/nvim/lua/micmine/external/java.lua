return {
  "nvim-java/nvim-java",
  ft = "java",
  dependencies = {
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-refactor",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    {
      "williamboman/mason.nvim",
      opts = {
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry",
        },
      },
    },
  },
  config = function()
    require("java").setup()
    local attach = require("micmine.util.attach")

    require("lspconfig").jdtls.setup({
      capabilities = attach.capabilities,
      on_attach = attach.on_attach,
    })
  end,
}
