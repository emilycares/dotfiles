return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    "ryanoasis/vim-devicons",
  },
  keys = {
    {
      "<C-t>",
      function()
        vim.cmd("NvimTreeFindFileToggle")
      end,
    },
  },
  config = function()
    local angular = require("emilycares.util.angular");
    local function custom_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "<leader>gc", function()
        angular.generate("component")
      end, opts("Generate Component"))
    end
    require("nvim-tree").setup({ on_attach = custom_attach })
  end,
}
