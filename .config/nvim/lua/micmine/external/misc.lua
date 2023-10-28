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
        "<leader>g",
        function() end,
      },
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
  { "scrooloose/nerdcommenter", event = "InsertEnter" },

  -- clean buffers
  { "Asheq/close-buffers.vim", event = "VeryLazy" },

  -- cooperation
  {
    "krivahtoo/silicon.nvim",
    cmd = "Silicon",
    build = "./install.sh build",
    config = function()
      require("silicon").setup({
        font = "SauceCodePro Nerd Font=16",
        theme = "onehalfdark",
        window_controls = false,
        line_pad = 0,
        pad_horiz = 0,
        pad_vert = 0,
        round_corner = false,
        line_offset = 0,
      })
    end,
  },
  { "shortcuts/no-neck-pain.nvim", cmd = "NoNeckPain", version = "*" },

  {
    "mbbill/undotree",
    keys = {
      {
        "<F8>",
        function()
          vim.cmd("UndotreeToggle")
        end,
      },
    },
  },
}
