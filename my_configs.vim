set number
set encoding=utf-8
set ttymouse=sgr
set mouse=a
set clipboard+=autoselect
set guioptions+=a
let g:vim_jsx_pretty_colorful_config = 1 " default 0"
let g:jsx_ext_required = 0 
let g:javascript_plugin_flow = 1
let g:xml_syntax_folding = 0
syntax enable
colorscheme dracula

" Start NERDTree on left side of window
let g:NERDTreeWinPos = "left"
" Start NERDTree when Vim is opened and leave the cursor in it.
autocmd VimEnter * NERDTree
"
" " Start NERDTree when Vim is opened and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
"
"" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif"
" Close NERDTree tab when file is closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") 
      \ && b:NERDTree.isTabTree()) | q | endif
