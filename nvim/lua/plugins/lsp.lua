return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap - no reuse_win
      keys[#keys + 1] = { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = false }) end, desc = "Goto Definition", has = "definition" }
      -- change a keymap - use built-in lsp instead of telescope for loclist
      keys[#keys + 1] = { "gr", vim.lsp.buf.references, { loclist = true }, desc = "References" }
      -- disable keymaps
      keys[#keys + 1] = { "]]", false }
      keys[#keys + 1] = { "[[", false }

      -- disable lang servers
      opts.servers['jsonls'] = nil
      opts.servers['lua_ls'] = nil
    end,
  },
}
