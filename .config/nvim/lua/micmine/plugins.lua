vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- lib
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'
  use 'rktjmp/lush.nvim' -- gruvbox

  -- Ui
  use 'hoob3rt/lualine.nvim'
  use 'mbbill/undotree'
  use 'kdheepak/lazygit.nvim'

  -- Movment
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-telescope/telescope.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use 'micmine/jumpwire.nvim'
  use 'ThePrimeagen/harpoon'

  -- theme
  use 'joshdick/onedark.vim'
  use 'pineapplegiant/spaceduck'
  use 'Shatur/neovim-ayu'
  use 'gruvbox-community/gruvbox'
  use 'folke/tokyonight.nvim'
  use 'shaunsingh/nord.nvim'
  use {'shaunsingh/oxocarbon.nvim', run = './install.sh'}

  -- git
  use 'tpope/vim-fugitive'
  use 'ThePrimeagen/git-worktree.nvim'

  -- preview
  use 'norcalli/nvim-colorizer.lua'
  use 'smithbm2316/centerpad.nvim'

  -- IDE
  use {'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production'}
  use 'scrooloose/nerdcommenter'
  use 'chiel92/vim-autoformat'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'onsails/lspkind-nvim'
  use 'j-hui/fidget.nvim'
  use 'mfussenegger/nvim-jdtls'
  use 'ericpubu/lsp_codelens_extensions.nvim' -- plenary, nvim-dap
  use {'ms-jpq/coq_nvim', branch =  'coq'}
  use {'ms-jpq/coq.artifacts', branch = 'artifacts'}

  -- DAP
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  -- Language specific
  use 'saecki/crates.nvim'
  use 'simrat39/rust-tools.nvim'

  -- snipet
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  --use 'saadparwaiz1/cmp_luasnip'

  use 'aklt/plantuml-syntax'

  -- syntax
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'godlygeek/tabular'
  use 'editorconfig/editorconfig-vim'

  -- clean buffers
  use 'Asheq/close-buffers.vim'
end)
