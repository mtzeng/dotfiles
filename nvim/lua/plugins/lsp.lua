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
    end,
    opts = function(_, opts)
      opts.autoformat = false
      opts.servers['jsonls'] = nil
      opts.servers['lua_ls'] = nil
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    opts = {
      extensions = {
        inlay_hints = {
          only_current_line = true,
        },
      },
    },
  },
}
