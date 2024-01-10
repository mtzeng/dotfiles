-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- toggle options
vim.keymap.set("n", "<leader>ti", "<cmd>set ignorecase!<cr>", { desc = "Toggle Ignorecase" })
vim.keymap.set("n", "<leader>tl", "<cmd>set list!<cr>", { desc = "Toggle List" })
vim.keymap.set('n', '<leader>tn', '<cmd>set number! relativenumber!<cr>', { desc = "Toggle Line Numbers" })
vim.keymap.set("n", "<leader>tp", "<cmd>set paste!<cr>", { desc = "Toggle Paste" })

-- tabs
vim.keymap.set("n", "<M-1>", "1gt", {})
vim.keymap.set("n", "<M-2>", "2gt", {})
vim.keymap.set("n", "<M-3>", "3gt", {})
vim.keymap.set("n", "<M-4>", "4gt", {})
vim.keymap.set("n", "<M-5>", "5gt", {})
vim.keymap.set("n", "<M-6>", "6gt", {})
vim.keymap.set("n", "<M-7>", "7gt", {})
vim.keymap.set("n", "<M-8>", "8gt", {})
vim.keymap.set("n", "<M-9>", "9gt", {})
vim.keymap.set("n", "<M-0>", "10gt", {})

vim.keymap.set("n", "th", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "tl", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "tn", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "tc", "<cmd>tabclose<cr>", { desc = "Close Tab" })
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

vim.keymap.set("n", "<leader>xl", "<cmd>LToggle<cr>", { desc = "Toggle location list" })
vim.keymap.set("n", "<leader>xq", "<cmd>QToggle<cr>", { desc = "Toggle quickfix list" })
vim.keymap.set("n", "[l", function() vim.cmd(vim.v.count1 .. "lprev") end, { desc = "Previous location list item" })
vim.keymap.set("n", "[L", "<cmd>lfirst<cr>", { desc = "First location list item" })
vim.keymap.set("n", "]l", function() vim.cmd(vim.v.count1 .. "lnext") end, { desc = "Next location list item" })
vim.keymap.set("n", "]L", "<cmd>llast<cr>", { desc = "Last location list item" })
