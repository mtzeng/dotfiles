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
  -- snippets
  -- { "nvim-cmp", enabled = false },
  -- auto pairs
  { "echasnovski/mini.pairs", enabled = false },
  -- comments
  { "folke/ts-comments.nvim", enabled = false },
  -- Better text-objects
  { "echasnovski/mini.ai", enabled = false },
  -- { "folke/lazydev.nvim", eanbled = false },
  -- Manage libuv types with lazy.
  -- { "Bilal2453/luvit-meta", enabled = false },

  -- colorscheme.lua
  -- tokyonight
  -- { "folke/tokyonight.nvim", enabled = false },
  -- catppuccin
  { "catppuccin/nvim", enabled = false },

  -- editor.lua
  -- file explorer
  -- { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  -- search/replace in multiple files
  { "MagicDuck/grug-far.nvim", enabled = false },
  -- Flash
  -- { "folke/flash.nvim", enabled = false },
  -- which-key
  -- { "folke/which-key.nvim", enabled = false },
  -- git signs
  { "lewis6991/gitsigns.nvim", enabled = false },
  -- better diagnostics list and others
  -- { "folke/trouble.nvim", enabled = false },
  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  { "folke/todo-comments.nvim", enabled = false },

  -- formatting.lua
  { "stevearc/conform.nvim", enabled = false },

  -- linting.lua
  { "mfussenegger/nvim-lint", enabled = false },

  -- treesitter.lua
  -- Treesitter
  -- { "nvim-treesitter/nvim-treesitter", enabled = false },
  -- { "nvim-treesitter/nvim-treesitter-textobjects", enabled = false },
  -- Automatically add closing tags for HTML and JSX
  -- { "windwp/nvim-ts-autotag", enabled = false },

  -- ui.lua
  -- bufferline
  { "akinsho/bufferline.nvim", enabled = false },
  -- statusline
  -- { "nvim-lualine/lualine.nvim", enabled = false },
  -- indent guides for Neovim
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  -- Highly experimental plugin that completely replaces the UI
  { "folke/noice.nvim", enabled = false },
  -- icons
  { "echasnovski/mini.icons", enabled = false },
  -- ui components
  -- { "MunifTanjim/nui.nvim", enabled = false },
  { "nvimdev/dashboard-nvim", enabled = false },

  -- util.lua
  -- Session management.
  { "folke/persistence.nvim", enabled = false },
  -- library used by other plugins
  -- { "nvim-lua/plenary.nvim", enabled = false },
}
