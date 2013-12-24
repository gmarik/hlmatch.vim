" get visual selection
func! s:vsel()
  let temp = @s
  norm! gv"sy
  let r = substitute(escape(@s, '\'), '\n', '\\n', 'g')
  let @s = temp
  return r
endf

" get current word
func! s:ncword()
  return expand("<cword>")
endf

" Highlight string
func! s:hl(str)
  let @/ = '\V'.a:str 
  set hls
  return a:str
endf

function! s:grep(str)
  let search = substitute(a:str, '\n', '\\n', 'g')
  execute 'noautocmd grep -R '.shellescape(a:str).' '.getcwd()
  copen
endfunction

" partial(substring) match
comm! HlmPartCword      call s:hl(s:ncword())
comm! HlmPartVSel       call s:hl(s:vsel())
comm! HlmPartGrepCword  call s:grep(s:hl(s:ncword()))
comm! HlmPartGrepVSel   call s:grep(s:hl(s:vsel()))

" exclusive match
comm! HlmCword      call s:hl('\<'.s:ncword().'\>')
comm! HlmVSel       call s:hl('\<'.s:vsel().'\>')
comm! HlmGrepCword  call s:grep(s:hl('\<'.s:ncword().'\>'))
comm! HlmGrepVSel   call s:grep(s:hl('\<'.s:vsel().'\>'))

" Mapping example
" nnoremap # :<C-u>HlmCword<CR>
" nnoremap <leader># :<C-u>HlmGrepCword<CR>
" vnoremap # :<C-u>HlmVSel<CR>
" vnoremap <leader># :<C-u>HlmGrepVSel<CR>
" 
" nnoremap ## :<C-u>HlmPartCword<CR>
" nnoremap <leader>## :<C-u>HlmPartGrepCword<CR>
" vnoremap ## :<C-u>HlmPartVSel<CR>
" vnoremap <leader>## :<C-u>HlmPartGrepVSel<CR>
