--[[
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "vim", "lua"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      node_decremental = "grc",
      scope_incremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false
--]]

