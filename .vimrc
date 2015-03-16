" disable left/right/up/down in insert mode
map <Left> <NOP>
map <Right> <NOP>
map <Up> <NOP>
map <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>

noremap ci< T>ct<
noremap ci> T>ct<

cnoremap <C-a> <Home>

" Set <C-C> to <ESC> so <C-C> during rectangular select preserves changes
ino <C-C> <Esc>

set tabstop=4
set shiftwidth=4
set smarttab

" let <Leader> be a space
let mapleader=" "

au BufRead,BufNewFile *.wk set filetype=wake
au BufRead,BufNewFile *.json set filetype=json

" Auto-reload vimrc on change
autocmd BufWritePre * :%s/\s\+$//e
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Pathogen allows easy plugin install/remove
execute pathogen#infect()

" enter add lines below selection
nnoremap <CR> o<Esc>

" change easymotion prefix from two spaces to one
map <Leader> <Plug>(easymotion-prefix)

" Keeping this around so I can make my own plugins later
function! ToggleComment()
  normal ^
  if( getline(".")[col(".") - 1] == "/")
    normal xx
  else
    normal i//
  endif
endfunction

" fix my common typos
autocmd VimEnter * Abolish reciev{e,ing,er,ers,es,ings,ed} receiv{}
autocmd VimEnter * Abolish f{un,nu}{ct,tc}{io,oi}n function
autocmd VimEnter * Abolish f{u,uu,}nction function
autocmd VimEnter * Abolish fu{n,nn,}ction function
autocmd VimEnter * Abolish fun{c,cc,}tion function
autocmd VimEnter * Abolish func{t,tt,}ion function
autocmd VimEnter * Abolish funct{i,ii,}on function
autocmd VimEnter * Abolish functi{o,oo,}n function
autocmd VimEnter * Abolish functio{n,nn,} function
autocmd VimEnter * Abolish fu{cn,cn}{ti,it}{no,on} function
autocmd VimEnter * Abolish uf{cn,cn}{ti,it}{no,on} function
autocmd VimEnter * Abolish pu{b,l,lb}ic public
autocmd VimEnter * Abolish a{n,nn}otation annotation
autocmd VimEnter * Abolish ann{a,o}t{a,o}t{oi,i,o}n annotation

" make write command case insensitive
command! W w

" Rename tabs to show tab number.
function! MyTabLine()
	let s = ''
	let wn = ''
	let t = tabpagenr()
	let i = 1
	while i <= tabpagenr('$')
		let buflist = tabpagebuflist(i)
		let winnr = tabpagewinnr(i)
		let s .= '%' . i . 'T'
		let s .= (i == t ? '%1*' : '%2*')
		let s .= ' '
		let wn = tabpagewinnr(i,'$')

		let s .= '%#TabLineNum#'
		let s .= i
		" let s .= '%*'
		let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
		let bufnr = buflist[winnr - 1]
		let file = bufname(bufnr)
		let buftype = getbufvar(bufnr, 'buftype')
		if buftype == 'nofile'
			if file =~ '\/.'
				let file = substitute(file, '.*\/\ze.', '', '')
			endif
		else
			let file = fnamemodify(file, ':p:t')
		endif
		if file == ''
			let file = '[No Name]'
		endif
		let s .= ' ' . file . ' '
		let i = i + 1
	endwhile
	let s .= '%T%#TabLineFill#%='
	let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
	return s
endfunction
set stal=2
set tabline=%!MyTabLine()
set showtabline=1
highlight link TabNum Special

hi TabLineNum ctermfg=LightRed ctermbg=Black
hi TabLine ctermfg=Blue ctermbg=Black
"#hi TabLineFill ctermfg=White
hi TabLineSel ctermfg=DarkRed ctermbg=Black

" Don't prefix omnigraphle sql with <C-C> as it delays cancellation
let g:ftplugin_sql_omni_key = '<C-H>'

" Don't enter command mode
map Q <NOP>