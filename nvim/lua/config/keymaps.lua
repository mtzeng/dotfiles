-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- toggle options
vim.keymap.set("n", "<leader>ti", "<cmd>set ignorecase!<cr>", { desc = "Toggle Ignorecase" })
vim.keymap.set("n", "<leader>tl", "<cmd>set list!<cr>", { desc = "Toggle List" })
vim.keymap.set('n', '<leader>tn', '<cmd>set number! relativenumber!<cr>', { desc = "Toggle Line Numbers" })
vim.keymap.set("n", "<leader>tp", "<cmd>set paste!<cr>", { desc = "Toggle Paste" })

-- tabs
vim.keymap.set("n", "tn", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "td", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "ts", "<cmd>tab split<cr>", { desc = "Split Tab" })

-- Bash like keys for the command line
vim.keymap.set('c', '<c-a>', '<home>', {})
vim.keymap.set('c', '<c-e>', '<end>', {})
vim.keymap.set('c', '<m-b>', '<s-left>', {})
vim.keymap.set('c', '<m-f>', '<s-right>', {})
-- https://stackoverflow.com/questions/11659618/altbackspace-to-delete-words-in-vim
vim.keymap.set('c', '<esc><bs>', '<c-w>', {})

vim.keymap.del("n", "H")
vim.keymap.del("n", "L")
