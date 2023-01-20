return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    { "mbbill/undotree", lazy = false }
  },
  keys = {
    {
      "<C-p>",
      function()
        require("telescope.builtin").find_files(require("telescope.themes").get_ivy())
      end,
    },
    {
      "<leader>tl",
      function()
        require("telescope.builtin").quickfix(require("telescope.themes").get_ivy())
      end,
    },
    {
      "<leader>tb",
      function()
        require("telescope.builtin").git_branches(require("telescope.themes").get_ivy())
      end,
    },
    {
      "<leader><c-d>",
      function()
        require("telescope.builtin").lsp_document_symbols(require("telescope.themes").get_ivy())
      end,
    },
    {
      "<leader><c-f>",
      function()
        require("telescope.builtin").live_grep(require("telescope.themes").get_ivy())
      end,
    },
    {
      "<leader>b",
      function()
        require("telescope.builtin").buffers(require("telescope.themes").get_ivy())
      end,
    },
  },
  config = function()
    require("nvim-treesitter.install").compilers = { "zig" }
    require("telescope").load_extension("fzf")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-q>"] = require("telescope.actions").send_to_qflist,
          },
        },
        file_ignore_patterns = { "package-lock.json", "Cargo.lock", "vendor", "node_modules", ".git" },
        previewer = false,
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        --["ui-select"] = {
        --require("telescope.themes").get_dropdown {}
        --}
      },
    })
  end,
}
