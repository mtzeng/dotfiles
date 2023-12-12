return {
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    event = 'VimEnter',
    opts = function(_, opts)
      -- opts.options.icons_enabled = false
      opts.options.theme = 'onedark'
      opts.options.component_separators = ''
      opts.options.section_separators = ''

      table.insert(opts.sections.lualine_a,
        { function() return "RO" end, cond = function() return not vim.o.modifiable end, })
      table.insert(opts.sections.lualine_a,
        { function() return "ICASE" end, cond = function() return vim.o.ignorecase end, })
      table.insert(opts.sections.lualine_a,
        { function() return "PASTE" end, cond = function() return vim.o.paste end, })
      table.insert(opts.sections.lualine_a,
        { function() return "LIST" end, cond = function() return vim.o.list end, })

      opts.tabline = opts.tabline or {}
      opts.tabline.lualine_a = opts.tabline.lualine_a or {}
      table.insert(opts.tabline.lualine_a,
        {
          'tabs',
          max_length = vim.o.columns,
          mode = 2,
          fmt = function(name, context)
            -- Show + if buffer is modified in tab
            local buflist = vim.fn.tabpagebuflist(context.tabnr)
            local winnr = vim.fn.tabpagewinnr(context.tabnr)
            local bufnr = buflist[winnr]
            local mod = vim.fn.getbufvar(bufnr, '&mod')

            return name .. (mod == 1 and ' +' or '')
          end,
        })
    end,
    config = function(_, opts)
      require('lualine').setup(opts)
      -- Auto hide tabline when only one tab page
      vim.api.nvim_create_autocmd({"UIEnter", "TabNew", "TabClosed"}, {
        callback = function()
          require('lualine').hide({place = {'tabline'}, unhide = (vim.fn.tabpagenr('$') > 1)})
        end,
      })
    end,
  },
}
