return {
  "kyazdani42/nvim-tree.lua",
  lazy = false,
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    "ryanoasis/vim-devicons",
  },
  keys = {
    {
      "<C-b>",
      function()
        vim.cmd("NvimTreeFindFileToggle")
      end,
    },
  },
  config = function()
    require("nvim-tree").setup()
  end,
}
