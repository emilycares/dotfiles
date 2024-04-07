return {
  {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.install").compilers = { "zig" }
      require("nvim-treesitter.configs").setup({
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
