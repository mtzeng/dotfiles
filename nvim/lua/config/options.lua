-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.colorcolumn = "80"
opt.expandtab = false
opt.ignorecase = false
opt.list = false
opt.listchars = { tab='»·', trail='·' }
opt.mouse = nil
opt.scrolloff = 0
opt.shiftwidth = 4
opt.tabstop = 4
opt.timeoutlen = 1000
-- https://superuser.com/questions/1761071/how-can-i-make-neovim-display-the-search-hit-bottom-continuing-at-top-message
opt.shortmess:append({ S = true })
