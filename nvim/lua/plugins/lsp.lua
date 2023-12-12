return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local bufopts = { noremap=true, silent=true, buffer=bufnr }

      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "gd", vim.lsp.buf.definition, bufopts }
      keys[#keys + 1] = { "gr", vim.lsp.buf.references, bufopts }

      local on_references = vim.lsp.handlers["textDocument/references"]
      vim.lsp.handlers["textDocument/references"] = vim.lsp.with(
        on_references, {
          -- Use location list instead of quickfix list
          loclist = true,
        }
      )
      -- disable autoformat
      vim.g.autoformat = false
    end,
    opts = function(_, opts)
      opts.servers['jsonls'] = nil
      opts.servers['lua_ls'] = nil
    end,
  },
  { import = "lazyvim.plugins.extras.lang.clangd" },
}
