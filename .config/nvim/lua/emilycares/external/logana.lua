return {
  "emilycares/logana.nvim",
  config = function()
    require("logana").analyze.set_parser("maven")
  end,
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
    {
      "<leader>h",
      function()
        require("logana").analyze.run("line", "size")
      end,
    },
  },
}
