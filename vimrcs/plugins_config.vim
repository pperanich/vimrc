"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important:
"       This requires that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
let s:vim_runtime = expand('<sfile>:p:h')."/.."
call pathogen#infect(s:vim_runtime.'/sources_forked/{}')
call pathogen#infect(s:vim_runtime.'/sources_non_forked/{}')
call pathogen#infect(s:vim_runtime.'/my_plugins/{}')
call pathogen#helptags()


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']

nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

" Quickly find and open a file in the current working directory
let g:ctrlp_map = '<C-f>'
map <leader>j :CtrlP<cr>

" Quickly find and open a buffer
map <leader>b :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'


""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'


""""""""""""""""""""""""""""""
" => snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
ino <C-j> <C-r>=snipMate#TriggerSnippet()<cr>
snor <C-j> <esc>i<right><C-r>=snipMate#TriggerSnippet()<cr>
let g:snipMate = { 'snippet_version' : 1 }


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_select_all_word_key = '<A-s>'
let g:multi_cursor_start_key           = 'g<C-s>'
let g:multi_cursor_select_all_key      = 'g<A-s>'
let g:multi_cursor_next_key            = '<C-s>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
			\ 'colorscheme': 'dracula',
			\ 'active': {
            \   'left': [
            \     ['mode', 'paste'],
            \     ['filename', 'readonly', 'eol', 'modified']],
            \   'right': [
			\     ['syntastic', 'lineinfo'],
            \     ['percent'],
            \     ['fugitive', 'filetype', 'fileencoding', 'fileformat']] },
            \ 'tabline': { 'left': [['tabs']], 'right': [[]] },
            \ 'tab': {
            \   'active': ['tabname', 'tabmodified'],
            \   'inactive': ['tabname', 'tabmodified'],
            \ },
            \ 'component': {
            \   'filename': '%<%{LightLineFilename()}',
			\ },
            \ 'component_function': {},
            \ 'tab_component_function': {},
            \ 'component_expand': {
            \   'readonly': 'LightLineReadonly',
            \   'eol': 'LightLineEol',
            \   'fugitive': 'LightLineFugitiveStatusline',
            \ },
            \ 'component_type': {
            \   'readonly': 'warning',
            \   'eol': 'warning',
            \ },
			\ 'separator': { 'left': '', 'right': '' },
			\ 'subseparator': { 'left': '', 'right': '' },
			\ }

for s:k in ['mode', 'modified', 'filetype', 'fileencoding',
			\ 'fileformat', 'percent', 'lineinfo']
	let g:lightline.component_function[s:k] =
				\ 'LightLine' . toupper(s:k[0]) . s:k[1:]
endfor
for s:k in ['name', 'modified']
	let g:lightline.tab_component_function['tab' . s:k] =
				\ 'LightLineTab' . toupper(s:k[0]) . s:k[1:]
endfor

function! LightLineWide(component)
	let component_visible_width = {
				\ 'mode': 70,
				\ 'fileencoding': 70,
				\ 'fileformat': 70,
				\ 'filetype': 70,
				\ 'percent': 50 }
	return winwidth(0) >= get(component_visible_width, a:component, 0)
endfunction

function! LightLineVisible(component)
	let fname = expand('%:t')
	return fname !=# '__Tag_List__' &&
				\ fname !=# 'ControlP' &&
				\ fname !~# 'NERD_tree' &&
				\ LightLineWide(a:component)
endfunction

function! LightLineMode()
	let short_mode_map = {
				\ 'n': 'N',
				\ 'i': 'I',
				\ 'R': 'R',
				\ 'v': 'V',
				\ 'V': 'V',
				\ 'c': 'C',
				\ "\<C-v>": 'V',
				\ 's': 'S',
				\ 'S': 'S',
				\ "\<C-s>": 'S',
				\ 't': 'T',
				\ '?': ' ' }
	let fname = expand('%:t')
	return fname ==# '__Tag_List__' ? 'TagList' :
				\ fname ==# 'ControlP' ? 'CtrlP' :
				\ fname =~# 'NERD_tree' ? '' :
				\ LightLineWide('mode') ? lightline#mode() :
				\ get(short_mode_map, mode(), short_mode_map['?'])
endfunction

function! LightLineFilename()
	let fname = expand('%:t')
	let fpath = expand('%')
	return &filetype ==# 'dirvish' ?
				\   (fpath ==# getcwd() . '/' ? fnamemodify(fpath, ':~') :
				\   fnamemodify(fpath, ':~:.')) :
				\ &buftype ==# 'terminal' ? fpath :
				\ &filetype ==# 'fzf' ? 'fzf' :
				\ &filetype ==# 'vim-plug' ? fpath :
				\ fname ==# '__Tag_List__' ? '' :
				\ fname ==# 'ControlP' ? '' :
				\ fname =~# 'NERD_tree' ?
				\   (index(['" Press ? for help', '.. (up a dir)'], getline('.')) < 0 ?
				\     matchstr(getline('.'), '[0-9A-Za-z_/].*') : '') :
				\ '' !=# fname ? fnamemodify(fpath, ':~:.') : '[No Name]'
endfunction

function! LightLineReadonly()
	return &readonly ? 'RO' : ''
endfunction

function! LightLineEol()
	return &endofline ? '' : 'NOEOL'
endfunction

function! LightLineModified()
	return &modified ? '+' : ''
endfunction

function! LightLineFiletype()
	return LightLineVisible('filetype') ?
				\ (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
	return LightLineVisible('fileencoding') ?
				\ (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! LightLineFileformat()
	return LightLineVisible('fileformat') ? &fileformat : ''
endfunction

function! LightLinePercent()
	return LightLineVisible('percent') ? (100 * line('.') / line('$')) . '%' : ''
endfunction

function! LightLineLineinfo()
	return LightLineVisible('lineinfo') ?
				\ printf('%3d:%-2d', line('.'), col('.')) : ''
endfunction

function! LightLineTabName(n)
	let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let fname = expand('#' . bufnr . ':t')
	return fname =~# '__Tagbar__' ? 'Tagbar' :
				\ fname =~# 'NERD_tree' ? 'NERDTree' : 
				\ ('' != fname ? fname : '[No Name]')
endfunction

function! LightLineTabModified(n)
	let winnr = tabpagewinnr(a:n)
	return gettabwinvar(a:n, winnr, '&modified') ? '⚡' : ''
endfunction

function! LightLineFugitiveStatusline()
	if @% !~# '^fugitive:'
		return ''
	endif
	let head = FugitiveHead()
	if !len(head)
		return ''
	endif
	let commit = matchstr(FugitiveParse()[0], '^\x\+')
	if len(commit)
		return head . ':' . commit[0:6]
	else
		return head
	endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale (syntax checker and linter)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
			\   'javascript': ['eslint'],
			\   'python': ['flake8'],
			\   'go': ['go', 'golint', 'errcheck']
			\}

nmap <silent> <leader>a <Plug>(ale_next_wrap)

" Disabling highlighting
let g:ale_set_highlights = 0

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => EditorConfig (project-specific EditorConfig rule)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
