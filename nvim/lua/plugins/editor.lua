local Util = require("lazyvim.util")

return {
  -- flash.nvim
  {
    "folke/flash.nvim",
    opts = {
      label = {
        after = false,
        before = { 0, 0 },
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
            ['<C-y>'] = require('telescope.actions.layout').toggle_preview
          },
        },
        sorting_strategy = "ascending",
        layout_strategy = "bottom_pane",
      },
    },
  },
  -- vim-signify
  {
    "mhinz/vim-signify",
    config = function()
      vim.cmd("highlight SignifySignAdd    ctermfg=green  guifg=#00ff00 cterm=NONE gui=NONE")
      vim.cmd("highlight SignifySignDelete ctermfg=red    guifg=#ff0000 cterm=NONE gui=NONE")
      vim.cmd("highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE")

      vim.cmd("nmap <leader>gj <plug>(signify-next-hunk)")
      vim.cmd("nmap <leader>gk <plug>(signify-prev-hunk)")
      vim.cmd("nmap <leader>gJ 9999<leader>gj")
      vim.cmd("nmap <leader>gK 9999<leader>gk")

      vim.cmd([[
        function! s:show_current_hunk() abort
          let h = sy#util#get_hunk_stats()
          if !empty(h)
            echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
          endif
        endfunction

        autocmd User SignifyHunk call s:show_current_hunk()
      ]])
    end,
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
      vim.keymap.set('n', '<leader>vl', ':VCSLog <c-r>=matchstr(getline(\'.\'), \'^\\s*\\(\\x\\+\\)\')<cr><cr>', {})
    end,
  },
  -- ListToggle
  {
    "Valloric/ListToggle",
    init = function()
      vim.g.lt_height = 12
    end,
  },
}
