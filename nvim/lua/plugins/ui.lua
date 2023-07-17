-- https://www.reddit.com/r/neovim/comments/pd8f07/using_treesitter_to_efficiently_show_the_function/
prev_function_node = nil
prev_function_name = ""

local function get_current_function()
  local ts_utils = require('nvim-treesitter.ts_utils')
  local current_node = ts_utils.get_node_at_cursor()
  
  if not current_node then
    return ""
  end
  
  local func = current_node
  while func do
    if func:type() == 'function_definition' then
      break
    end
    func = func:parent()
  end
  
  if not func then
    prev_function_node = nil
    prev_function_name = ""
    return ""
  end
  
  if func == prev_function_node then
    return prev_function_name
  end
  
  prev_function_node = func
  
  local find_name
  find_name = function(node)
    for i = 0, node:named_child_count() - 1, 1 do
      local child = node:named_child(i)
      local type = child:type()
  
      if type == 'identifier' or type == 'operator_name' then
        return (vim.treesitter.get_node_text(child, 0))
      else
        local name = find_name(child)
        if name then
          return name
        end
      end
    end
    return nil
  end
  
  prev_function_name = find_name(func)
  return prev_function_name
end

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
          lualine_c = {'filename', get_current_function},
        },
        inactive_sections = {
          lualine_c = {'filename', get_current_function},
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
