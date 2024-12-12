local config = require("codelens_extensions.config")
return {
  {
    "folke/neodev.nvim",
    ft = { "lua" },
    config = function()
      require("neodev").setup()
      local lspconfig = require("lspconfig")

      -- example to setup lua_ls and enable call snippets
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })
    end,
  },

  -- git
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gvdiffsplit" },
    keys = {
      {
        "<leader>gd",
        function()
          vim.cmd("Gvdiffsplit")
        end,
      },
      {
        "<leader>gb",
        function()
          vim.cmd("Git blame")
        end,
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    keys = {
      {
        "<leader>gu",
        function()
          vim.cmd("LazyGit")
        end,
      },
    },
    cmd = "LazyGit",
  },

  -- syntax
  { "godlygeek/tabular", cmd = "Tabularize" },

  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<F8>", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },

  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "lua" },
    config = function()
      require("colorizer").setup({ "css", "lua" })
    end,
  },
}
