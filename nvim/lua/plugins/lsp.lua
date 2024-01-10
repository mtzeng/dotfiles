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
          on_list = function(options)
            local height = vim.g.lt_height or 10
            vim.fn.setloclist(0, {}, ' ', options)
            vim.api.nvim_command('lopen ' .. height)
          end,
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
}
