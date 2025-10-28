return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ['*'] = {
        keys = {
          -- Change an existing keymap
          -- use built-in lsp instead of telescope for loclist
          { "gr", function() vim.lsp.buf.references(nil, { loclist = true }) end, desc = "References" },
          -- Disable a keymap
          { "]]", false },
          { "[[", false },
        },
      },
    },
  },
}
