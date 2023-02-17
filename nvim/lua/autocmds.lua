vim.cmd([[autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]])

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.lua", "*.vim", "*.sh" },
  command = "setlocal expandtab shiftwidth=2 tabstop=2",
})

