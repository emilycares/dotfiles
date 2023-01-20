return {
  "mhartington/formatter.nvim",
  keys = {
    {
      "<leader>f",
      function()
        vim.cmd([[Format]])
      end,
    },
  },
  config = function()
    require("formatter").setup({
      -- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
      filetype = {
        lua = {
          require("formatter.filetypes.lua").stylua,
        },
        rust = {
          require("formatter.filetypes.rust").rustfmt(),
        },
      },
    })
  end,
}
