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
    local lsp_format = {
      function()
        vim.lsp.buf.format()
      end,
    }
    require("formatter").setup({
      -- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
      filetype = {
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
        zig = lsp_format,
        rust = lsp_format,
        lua = lsp_format,
        go = lsp_format,
      },
    })
  end,
}
