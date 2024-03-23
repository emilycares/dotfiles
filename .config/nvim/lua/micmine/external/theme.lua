return {
  {
      "tjdevries/colorbuddy.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
      --"joshdick/onedark.vim",
      --"pineapplegiant/spaceduck",
      --"Shatur/neovim-ayu",
      --{
      --"gruvbox-community/gruvbox",
      --dependencies = { "rktjmp/lush.nvim" },
      --},
      --"folke/tokyonight.nvim",
      --"shaunsingh/nord.nvim",
      --"rebelot/kanagawa.nvim",
      --"bratpeki/truedark-vim",
      --"shaunsingh/oxocarbon.nvim",
      --"dasupradyumna/midnight.nvim",
      --"blazkowolf/gruber-darker.nvim",
      --"catppuccin/nvim",
      --"2nthony/vitesse.nvim", "tjdevries/colorbuddy.nvim",
      --"rose-pine/neovim", name = "rose-pine",
    },
    --install = {
      --colorscheme = { "vitesse" },
    --},
    config = function()
    vim.cmd.colorscheme("gruvbuddy")
    end,
  },
}
