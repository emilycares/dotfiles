return {
  "micmine/logana.nvim",
  keys = {
    {
      "ä",
      function()
        require("logana").set_qfl()
      end,
    },
    {
      "{",
      function()
        require("logana").set_qfl()
      end,
    },
  },
}
