-- TabLine
vim.cmd([[
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return fnamemodify(bufname(buflist[winnr - 1]), ":t")
endfunction

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s ..= '%#TabLineSel#'
    else
      let s ..= '%#TabLine#'
    endif

    " the label is made by MyTabLabel()
    let s ..= ' ' .. (i + 1) .. ' %{MyTabLabel(' .. (i + 1) .. ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s ..= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s ..= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

set tabline=%!MyTabLine()
]])

-- Netrw
vim.cmd([[
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20
]])

vim.keymap.set('n', '<f5>', ':Lexplore<cr>', {})
