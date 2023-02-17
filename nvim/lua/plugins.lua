return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
  }

  use 'Yggdroot/vim-mark'
  -- use 't9md/vim-quickhl'

  use 'nvim-lualine/lualine.nvim'

  use 'sk1418/last256'
  -- use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'
end)
