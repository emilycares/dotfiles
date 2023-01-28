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
      "<M-h>",
      function()
        require("harpoon.ui").nav_file(1)
      end,
    },
    {
      "<M-j>",
      function()
        require("harpoon.ui").nav_file(2)
      end,
    },
    {
      "<M-k>",
      function()
        require("harpoon.ui").nav_file(3)
      end,
    },
    {
      "<M-l>",
      function()
        require("harpoon.ui").nav_file(4)
      end,
    },
  },
  config = function()
    require("harpoon").setup()
  end,
}
