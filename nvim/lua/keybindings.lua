vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<leader>ti', ':set ignorecase!<cr>', {})
vim.keymap.set('n', '<leader>tl', ':set list!<cr>', {})
vim.keymap.set('n', '<leader>tn', ':set number! relativenumber!<cr>', {})
vim.keymap.set('n', '<leader>tp', ':set paste!<cr>', {})

vim.keymap.set('n', '<f7>', ':lprevious<cr>', {})
vim.keymap.set('n', '<f8>', ':lnext<cr>', {})

vim.keymap.set('n', 'tn', ':tabnew<cr>', {})
vim.keymap.set('n', 'tc', ':tabclose<cr>', {})
vim.keymap.set('n', 'ts', ':tab split <bar> if &diff != "" <bar> diffoff <bar> endif<cr>', {})

-- Bash like keys for the command line
vim.keymap.set('c', '<c-a>', '<home>', {})
vim.keymap.set('c', '<c-e>', '<end>', {})
vim.keymap.set('c', '<m-b>', '<s-left>', {})
vim.keymap.set('c', '<m-f>', '<s-right>', {})
-- https://stackoverflow.com/questions/11659618/altbackspace-to-delete-words-in-vim
vim.keymap.set('c', '<esc><bs>', '<c-w>', {})

vim.keymap.set('n', '<leader>vd', ':VCSVimDiff<cr>', {})
vim.keymap.set('n', '<leader>va', ':VCSVerticalAnnotate<cr>', {})
vim.keymap.set('n', '<leader>vl', ':VCSLog <c-r>=matchstr(getline("."), "^\\s*\\(\\x\\+\\)")<cr><cr>', {})
