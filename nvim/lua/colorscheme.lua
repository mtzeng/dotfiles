--[[
require("tokyonight").setup({
  -- use the night style
  style = "night",
  transparent = true,
  -- disable italic for functions
  styles = {
    functions = {}
  },
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  on_colors = function(colors)
    --colors.fg = "#cad1d8"
    colors.fg = "#c7c7c7"
  end
})
--]]

require('onedark').setup {
    style = 'dark',
    transparent = true
}
require('onedark').load()

vim.cmd('colorscheme onedark')
