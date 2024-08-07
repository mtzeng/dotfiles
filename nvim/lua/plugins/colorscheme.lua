return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "navarasu/onedark.nvim",
    opts = {
      transparent = true,
    }
  },
  -- Configure LazyVim to load colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  }
}
