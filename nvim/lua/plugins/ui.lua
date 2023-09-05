return {
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {
        --[[add your custom lualine config here]]
        options = {
          icons_enabled = false,
          theme = 'onedark',
          component_separators = '',
          section_separators = '',
        },
        sections = {
          lualine_a = {
            'mode',
            { function() return "RO" end, cond = function() return not vim.o.modifiable end, },
            { function() return "ICASE" end, cond = function() return vim.o.ignorecase end, },
            { function() return "PASTE" end, cond = function() return vim.o.paste end, },
            { function() return "LIST" end, cond = function() return vim.o.list end, },
          },
          lualine_c = {
            'filename',
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
          },
        },
        inactive_sections = {
          lualine_c = {
            'filename',
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
          },
        },
        tabline = {
          lualine_a = {
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
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require('lualine').setup(opts)
      -- Auto hide tabline when only one tab page
      vim.api.nvim_create_autocmd({"TabNew", "TabClosed"}, {
        callback = function()
          require('lualine').hide({place = {'tabline'}, unhide = (vim.fn.tabpagenr('$') > 1)})
        end,
      })
    end,
  },
}