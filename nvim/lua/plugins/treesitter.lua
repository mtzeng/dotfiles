return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      --[[
      -- https://github.com/nvim-treesitter/nvim-treesitter/issues/2383
      -- Error during compilation, ‘for’ loop initial declarations are only allowed in C99 mode
      -- export GCCVER=11.2.0; export CC=/tools/bin/gcc
      ensure_installed = {
        "c",
      },
      ]]
      indent = { enable = false },
      -- disable keymaps for textobjects
      textobjects = { move = { enable = false, }, },
    },
  },
}
