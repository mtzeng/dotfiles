-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.lua", "*.vim", "*.sh" },
  command = "setlocal expandtab shiftwidth=2 tabstop=2",
})

-- No diff folding to avoiding LSP performance problem
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  command = "if line('$') > 10000 | setlocal diffopt=internal,filler,closeoff,context:99999 | endif",
})

-- Remember the line I was on when I reopne a file
-- http://askubuntu.com/questions/202075/how-do-i-get-vim-to-remember-the-line-i-was-on-when-i-reopen-a-file
vim.cmd [[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]
