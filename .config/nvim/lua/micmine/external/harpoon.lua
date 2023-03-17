return {
  "ThePrimeagen/harpoon",
  keys = {
    -- asd
    {
      "<C-e>",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
    },
    {
      "<leader>a",
      function()
        require("harpoon.mark").add_file()
      end,
    },
    {
      "<M-1>",
      function()
        require("harpoon.ui").nav_file(1)
      end,
    },
    {
      "<M-2>",
      function()
        require("harpoon.ui").nav_file(2)
      end,
    },
    {
      "<M-3>",
      function()
        require("harpoon.ui").nav_file(3)
      end,
    },
    {
      "<M-4>",
      function()
        require("harpoon.ui").nav_file(4)
      end,
    },
  },
  config = function()
    require("harpoon").setup()
  end,
}
