-- Netrw
vim.cmd([[
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20
]])

vim.keymap.set('n', '<f5>', ':Lexplore<cr>', {})

return {
  -- vimwiki
  {
    "vimwiki/vimwiki",
    keys = { { "<leader>wt", "<Plug>VimwikiTabIndex", desc = "Open default wiki index file in a new tab." } },
  },
  -- vim-dirdiff
  {
    "will133/vim-dirdiff",
    init = function()
      vim.treesitter.language.register("diff", "dirdiff")
    end,
  }
}
