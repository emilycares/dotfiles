return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    "ryanoasis/vim-devicons",
  },
  keys = {
    {
      "<C-t>",
      function()
        vim.cmd("NvimTreeFindFileToggle")
      end,
    },
  },
  config = function()
    require("nvim-tree").setup()
  end,
}
