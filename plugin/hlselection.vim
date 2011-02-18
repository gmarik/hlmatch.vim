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
  execute 'noautocmd vimgrep /'.a:str.'/ **'
  copen
endfunction

comm! HlSelCword      call s:hl(s:ncword())
comm! HlSelVSel       call s:hl(s:vsel())
comm! HlSelGrepCword  call s:grep(s:hl(s:ncword()))
comm! HlSelGrepVSel   call s:grep(s:hl(s:vsel()))
