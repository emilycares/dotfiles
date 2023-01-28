return {
  -- Ui
  { "kdheepak/lazygit.nvim", cmd = "LazyGit" },

  -- git
  { "tpope/vim-fugitive", cmd = { "Git", "Gvdiffsplit" } },

  -- LSP
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("micmine.snippet")
    end,
  },

  -- syntax
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of language_version
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "godlygeek/tabular", cmd = "Tabularize" },
  { "editorconfig/editorconfig-vim", event = "InsertEnter" },
  { "scrooloose/nerdcommenter", event = "InsertEnter"}, 

  -- clean buffers
  { "Asheq/close-buffers.vim", event = "VeryLazy" },

  -- cooperation
  { "krivahtoo/silicon.nvim", event = "VeryLazy", build = "./install.sh" },
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
