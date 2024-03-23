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
          require("formatter.filetypes.lua").stylua(),
        },
        rust = {
          require("formatter.filetypes.rust").rustfmt(),
        },
        zig = {
          require("formatter.filetypes.zig").zigfmt(),
        },
        go = {
          require("formatter.filetypes.go").gofmt(),
        },
        typescript = {
          require("formatter.filetypes.typescript").prettierd(),
        },
        html = {
          require("formatter.filetypes.html").prettierd(),
        },
        css = {
          require("formatter.filetypes.css").prettierd(),
        },
        json = {
          require("formatter.filetypes.json").jq(),
        },
      },
    })
  end,
}
