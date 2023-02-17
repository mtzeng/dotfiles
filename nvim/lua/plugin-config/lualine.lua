local function paste()
  if vim.o.paste then
    return '| PASTE'
  else
    return ''
  end
end

local function ignorecase()
  if vim.o.ignorecase then
    return '| IGNORECASE'
  else
    return ''
  end
end
local function list()
  if vim.o.list then
    return '| LIST'
  else
    return ''
  end
end

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode', paste, ignorecase, list, }
  },
}
