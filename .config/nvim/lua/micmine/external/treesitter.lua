return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.install").compilers = { "zig" }
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of language_version
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    config = function()
      require("treesitter-context").setup({
        enable = true
      })
    end,
  }
}
