vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "micmine.external" },
  },
  defaults = { lazy = true },
  -- lib
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "jose-elias-alvarez/null-ls.nvim",

  -- Ui
  "mbbill/undotree",
  "kdheepak/lazygit.nvim",
  "nvim-zh/colorful-winsep.nvim",

  -- git
  "tpope/vim-fugitive",
  "ThePrimeagen/git-worktree.nvim",

  -- preview
  "norcalli/nvim-colorizer.lua",
  "smithbm2316/centerpad.nvim",

  -- IDE
  { "prettier/vim-prettier", build = "yarn install --frozen-lockfile --production" },

  -- LSP
  "mfussenegger/nvim-jdtls",
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
  -- DAP
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",

  -- snipet

  "aklt/plantuml-syntax",

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
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  "godlygeek/tabular",
  { "editorconfig/editorconfig-vim", event = "InsertEnter" },

  -- clean buffers
  { "Asheq/close-buffers.vim", event = "VeryLazy" },

  -- cooperation
  { "krivahtoo/silicon.nvim", event = "VeryLazy", build = "./install.sh" },
  { "shortcuts/no-neck-pain.nvim", event = "VeryLazy", tag = "*" },

  { "mbbill/undotree", lazy = false }
})
