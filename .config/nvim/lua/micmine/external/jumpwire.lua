return {
  "micmine/jumpwire.nvim",
  keys = {
    -- asd
    {
      "<M-t>",
      function()
        require("jumpwire").jump("test")
      end,
    },
    {
      "<M-i>",
      function()
        require("jumpwire").jump("implementation")
      end,
    },
    {
      "<M-m>",
      function()
        require("jumpwire").jump("markup")
      end,
    },
    {
      "<M-s>",
      function()
        require("jumpwire").jump("style")
      end,
    },
  },
  config = function()
    require("jumpwire").setup({
      language = {
        ["html"] = {
          implementation = { type = "fileExtension", data = "ts" },
          test = { type = "fileExtension", data = "spec.ts" },
          style = { type = "fileExtension", data = "scss" },
        },
        ["scss"] = {
          implementation = { type = "fileExtension", data = "ts" },
          test = { type = "fileExtension", data = "spec.ts" },
          markup = { type = "fileExtension", data = "html" },
        },
        ["spec.ts"] = {
          implementation = { type = "fileExtension", data = "ts" },
          markup = { type = "fileExtension", data = "html" },
          style = { type = "fileExtension", data = "scss" },
        },
        ["ts"] = {
          test = { type = "fileExtension", data = "spec.ts" },
          markup = { type = "fileExtension", data = "html" },
          style = { type = "fileExtension", data = "scss" },
        },
        ["java"] = {
          implementation = { type = "jvm", data = "implementation" },
          test = { type = "jvm", data = "test" },
        },
        ["rs"] = {
          test = { type = "fileExtension", delimiter = "_", data = "_test.rs" },
          implementation = { type = "fileExtension", delimiter = "_", data = "rs" },
        },
      },
    })
  end,
}
