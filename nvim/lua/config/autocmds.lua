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
  command = "setlocal diffopt=internal,filler,closeoff,context:99999",
})
