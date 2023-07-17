return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local bufopts = { noremap=true, silent=true, buffer=bufnr }

      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
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
    --[[
    config = function()
      local on_references = vim.lsp.handlers["textDocument/references"]
      vim.lsp.handlers["textDocument/references"] = vim.lsp.with(
        on_references, {
          -- Use location list instead of quickfix list
          loclist = true,
        }
      )
    end,
    ]]
    opts = {
      extensions = {
        ast = {
          -- These are unicode, should be available in any font
          role_icons = {
            type = "🄣",
            declaration = "🄓",
            expression = "🄔",
            statement = ";",
            specifier = "🄢",
            ["template argument"] = "🆃",
          },
          kind_icons = {
            Compound = "🄲",
            Recovery = "🅁",
            TranslationUnit = "🅄",
            PackExpansion = "🄿",
            TemplateTypeParm = "🅃",
            TemplateTemplateParm = "🅃",
            TemplateParamObject = "🅃",
          },
        },
      },
    },
  }
}
