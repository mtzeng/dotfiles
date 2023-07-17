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
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
  }

  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  use 'Yggdroot/vim-mark'
  use {
    'Valloric/ListToggle',
    config = function()
      vim.g.lt_location_list_toggle_map = '<f9>'
      vim.g.lt_quickfix_list_toggle_map = '<s-f9>'
      vim.g.lt_height = 12
    end
  }

  use {
    'inkarkat/vcscommand.vim',
    config = vim.cmd[[
let VCSCommandDisableMappings = 1
let VCSCommandDeleteOnHide = 1
augroup VCSCommand
autocmd User VCSBufferCreated silent! nmap <unique> <buffer> q :bwipeout<cr>
autocmd User VCSVimDiffFinish wincmd p
augroup VCSCommand

function! s:vcs_vertical_annotate()
  let origin = ''

  if exists("g:VCSCommandSplit")
    let origin = g:VCSCommandSplit
  endif
  let g:VCSCommandSplit='vertical'

  VCSAnnotate
  set scrollbind
  wincmd p
  set scrollbind
  wincmd p

  if origin == ''
    unlet g:VCSCommandSplit
  elseif origin != g:VCSCommandSplit
    let g:VCSCommandSplit = origin
  endif
endfunction
command! VCSVerticalAnnotate call s:vcs_vertical_annotate()
    ]]
  }

  use 'nvim-lualine/lualine.nvim'

  -- use 'sk1418/last256'
  -- use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'
end)
