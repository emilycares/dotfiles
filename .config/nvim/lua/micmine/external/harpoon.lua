return {
  "ThePrimeagen/harpoon",
  keys = {
    -- asd
    {
      "<M-u>",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
    },
    {
      "<M-y>",
      function()
        require("harpoon.mark").add_file()
      end,
    },
    {
      "<M-w>",
      function()
        require("harpoon.ui").nav_file(1)
      end,
    },
    {
      "<M-e>",
      function()
        require("harpoon.ui").nav_file(2)
      end,
    },
    {
      "<M-r>",
      function()
        require("harpoon.ui").nav_file(3)
      end,
    },
    {
      "<M-t>",
      function()
        require("harpoon.ui").nav_file(4)
      end,
    },
  },
  config = function()
    require("harpoon").setup()
  end,
}
