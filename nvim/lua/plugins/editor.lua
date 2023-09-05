local Util = require("lazyvim.util")

return {
  -- flash.nvim
  {
    "folke/flash.nvim",
    opts = {
      label = {
        after = false,
        before = true,
      },
    },
  },
  -- telescope
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    opts = {
      defaults = {
        prompt_prefix = ">> ",
        selection_caret = "> ",
        -- https://www.reddit.com/r/neovim/comments/pzxw8h/telescope_quit_on_first_single_esc/
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
      pickers = {
        git_files = { theme = "ivy", },
        live_grep = { theme = "ivy", },
        current_buffer_fuzzy_find = { theme = "ivy", },
        lsp_document_symbols = { theme = "ivy", },
      },
    },
    keys = {
      { "<leader>gf", "<cmd>Telescope git_files<CR>", desc = "files" },
      { "<leader>sG", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sg", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    },
  },
  -- vim-signify
  {
    "mhinz/vim-signify",
    config = function()
      vim.cmd("highlight SignifySignAdd    ctermfg=green  guifg=#00ff00 cterm=NONE gui=NONE")
      vim.cmd("highlight SignifySignDelete ctermfg=red    guifg=#ff0000 cterm=NONE gui=NONE")
      vim.cmd("highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE")
    end
  },
  -- vim-mark
  { "Yggdroot/vim-mark" },
  -- vcscommand
  {
    "inkarkat/vcscommand.vim",
    config = function()
      vim.g.VCSCommandDisableMappings = 1
      vim.g.VCSCommandDeleteOnHide = 1

      vim.api.nvim_create_autocmd('User', {
        group   = 'VCSCommand',
        pattern = 'VCSVimDiffFinish',
        command = 'wincmd p',
      })

      vim.api.nvim_create_autocmd('User', {
        group   = 'VCSCommand',
        pattern = 'VCSBufferCreated',
        command = 'silent! nmap <unique> <buffer> q :bwipeout<cr>',
      })

      VCSVerticalAnnotate = function()
        local split = vim.g.VCSCommandSplit
        vim.g.VCSCommandSplit = 'vertical'

        vim.cmd("set noscrollbind")
        vim.cmd("normal! zz")
        vim.cmd("VCSAnnotate")
        vim.cmd("set scrollbind")
        vim.cmd("wincmd p")
        vim.cmd("set scrollbind")

        vim.g.VCSCommandSplit = split
      end

      vim.keymap.set('n', '<leader>va', VCSVerticalAnnotate, {})
      vim.keymap.set('n', '<leader>vd', ':VCSVimDiff<cr>', {})
      vim.keymap.set('n', '<leader>vl', ':VCSLog <c-r>=matchstr(getline("."), "^\\s*\\(\\x\\+\\)")<cr><cr>', {})
    end,
  },
  -- ListToggle
  {
    "Valloric/ListToggle",
    init = function()
      vim.g.lt_location_list_toggle_map = '<f9>'
      vim.g.lt_quickfix_list_toggle_map = '<s-f9>'
      vim.g.lt_height = 12
    end,
  },
}
