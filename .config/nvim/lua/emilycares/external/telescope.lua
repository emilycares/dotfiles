return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  cmd = { "Telescope" },
  keys = {
    {
      "<leader>ff",
      function()
        if vim.fn.filereadable("angular.json") == 1 then
          require("telescope.builtin").find_files({
            find_command = {
              "rg",
              "--files",
              "--color",
              "never",
              "--glob",
              "*.ts",
              "--glob",
              "!*.spec.ts",
            },
          })
          return
        end
        require("telescope.builtin").find_files()
      end,
    },
    {
      "<leader>fa",
      function()
        require("telescope.builtin").find_files()
      end,
    },
    {
      "<leader>fl",
      function()
        require("telescope.builtin").quickfix()
      end,
    },
    {
      "<leader><c-d>",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols()
      end,
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
    },
  },
  config = function()
    require("telescope").setup({
      pickers = {
        find_files = {
          previewer = false
        }
      },
      defaults = {
        mappings = {
          i = {
            ["<C-q>"] = require("telescope.actions").send_to_qflist,
          },
        },
        file_ignore_patterns = { "package-lock.json", "Cargo.lock", "vendor", "node_modules", ".git" },

        -- modifyed ivy
        sorting_strategy = "ascending",
        layout_strategy = "bottom_pane",
        layout_config = {
          height = 10,
        },
        border = true,
        borderchars = {
          prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
          results = { " " },
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
    -- setup quarkus find routes with https://github.com/emilycares/qute-lsp
    require("emilycares.util.quarkus")
  end,
}
