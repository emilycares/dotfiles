return {
  {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2",
    lazy = false,
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require("nvim-treesitter.install").compilers = { "zig" }
      require("nvim-treesitter.configs").setup({
        modules = {},
        ignore_install = {},
        auto_install = true,
        ensure_installed = {
          "typescript",
          "html",
          "css",
          "rust",
          "c",
          "cpp",
          "ocaml",
          "go",
          "java",
          "zig",
          "v",
        },
        sync_install = true,
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
            node_incremental = "<M-w>", -- increment to the upper named parent
            node_decremental = "<M-C-w>", -- decrement to the previous node
            scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
          },
        },

        textobjects = {
          move = {
            enable = true,
            set_jumps = true,

            goto_next_start = {
              ["]p"] = "@parameter.inner",
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[p"] = "@parameter.inner",
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },

          select = {
            enable = true,
            lookahead = true,

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",

              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",

              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",

              ["av"] = "@variable.outer",
              ["iv"] = "@variable.inner",
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "TSPlaygroundToggle",
  },
  --{
  --"nvim-treesitter/nvim-treesitter-context",
  --dependencies = "nvim-treesitter/nvim-treesitter",
  --event = "BufReadPre",
  --config = function()
  --require("treesitter-context").setup({
  --enable = true,
  --})
  --end,
  --},
}
