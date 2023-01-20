return {
  "micmine/logana.nvim",
  keys = {
    {
      "ä",
      function()
        require("logana").set_qfl()
      end,
    },
  },
}
