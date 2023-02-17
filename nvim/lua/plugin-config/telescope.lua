local telescope = require('telescope')
local actions = require("telescope.actions")
local builtin = require('telescope.builtin')

telescope.setup{
  defaults = {
    -- https://www.reddit.com/r/neovim/comments/pzxw8h/telescope_quit_on_first_single_esc/
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
  pickers = {
    git_files = {
      theme = "ivy",
    },
  },
}

telescope.load_extension('fzf')

vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
vim.keymap.set('n', '<leader>fF', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ft', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fl', builtin.current_buffer_fuzzy_find, {})

--[[
local highlights = {
  TelescopeSelection = { ctermbg = 238 },
}

for k, v in pairs(highlights) do
  vim.api.nvim_set_hl(0, k, v)
end
--]]
