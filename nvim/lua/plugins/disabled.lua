return {
  -- $HOME/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins
  
  -- lsp/init.lua
  -- lspconfig
  -- { "neovim/nvim-lspconfig", enabled = false },
  -- cmdline tools and lsp servers
  { "williamboman/mason.nvim", enabled = false },

  -- coding.lua
  -- auto completion
  -- { "hrsh7th/nvim-cmp", enabled = false },
  -- auto pairs
  { "echasnovski/mini.pairs", enabled = false },
  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", enabled = false },
  -- Better text-objects
  { "echasnovski/mini.ai", enabled = false },

  -- colorscheme.lua
  -- tokyonight
  -- { "folke/tokyonight.nvim", enabled = false },
  -- catppuccin
  { "catppuccin/nvim", enabled = false },

  -- editor.lua
  -- file explorer
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  -- search/replace in multiple files
  { "nvim-pack/nvim-spectre", enabled = false },
  -- Fuzzy finder.
  -- { "nvim-telescope/telescope.nvim", enabled = false },
  -- Flash
  -- { "folke/flash.nvim", enabled = false },
  -- which-key
  -- { "folke/which-key.nvim", enabled = false },
  -- git signs
  { "lewis6991/gitsigns.nvim", enabled = false },
  -- better diagnostics list and others
  { "folke/trouble.nvim", enabled = false },
  -- todo comments
  { "folke/todo-comments.nvim", enabled = false },

  -- formatting.lua
  { "stevearc/conform.nvim", enabled = false },

  -- linting
  { "mfussenegger/nvim-lint", enabled = false },

  -- treesitter.lua
  -- Treesitter
  -- { "nvim-treesitter/nvim-treesitter", enabled = false },
  -- Show context of the current function
  -- { "nvim-treesitter/nvim-treesitter-context", enabled = false },
  -- Automatically add closing tags for HTML and JSX
  -- { "windwp/nvim-ts-autotag", enabled = false },

  -- ui.lua
  -- Better `vim.notify()`
  { "rcarriga/nvim-notify", enabled = false },
  -- better vim.ui
  { "stevearc/dressing.nvim", enabled = false },
  -- bufferline
  { "akinsho/bufferline.nvim", enabled = false },
  -- statusline
  -- { "nvim-lualine/lualine.nvim", enabled = false },
  -- indent guides for Neovim
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  -- Highly experimental plugin that completely replaces the UI
  { "folke/noice.nvim", enabled = false },
  -- icons
  { "nvim-tree/nvim-web-devicons", enabled = false },
  -- ui components
  { "MunifTanjim/nui.nvim", enabled = false },
  { "goolord/alpha-nvim", enabled = false },
  -- { "nvimdev/dashboard-nvim", enabled = false },

  -- util
  -- Session management.
  { "folke/persistence.nvim", enabled = false },
  -- library used by other plugins
  -- { "nvim-lua/plenary.nvim", enabled = false },
}
