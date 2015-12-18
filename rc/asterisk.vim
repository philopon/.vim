function! neobundle#hooks.on_source(bundle)
    let g:asterisk#keeppos = 1
endfunction

map *   <Plug>(asterisk-z*)
map #   <Plug>(asterisk-z#)
map g*  <Plug>(asterisk-gz*)
map g#  <Plug>(asterisk-gz#)
