-- Netrw
vim.cmd([[
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20
]])

vim.keymap.set('n', '<f5>', ':Lexplore<cr>', {})

return {
}
