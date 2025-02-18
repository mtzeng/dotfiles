return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap - no reuse_win
      keys[#keys + 1] = { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" }
      -- change a keymap - use built-in lsp instead of telescope for loclist
      keys[#keys + 1] = { "gr", function() vim.lsp.buf.references(nil, { loclist = true }) end, desc = "References" }
      -- disable keymaps
      keys[#keys + 1] = { "]]", false }
      keys[#keys + 1] = { "[[", false }

      -- disable lang servers
      opts.servers['jsonls'] = nil
      opts.servers['lua_ls'] = nil

      -- disable inlay hints
      -- https://github.com/LazyVim/LazyVim/discussions/3191
      opts.inlay_hints.enabled = false
    end,
  },
}
