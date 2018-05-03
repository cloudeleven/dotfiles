" vim: set ts=4 sw=4 sts=0:

"-----------------------------------------------------------------------------
" 一旦ファイルタイプ関連を無効化する
filetype off
filetype plugin indent off
"-----------------------------------------------------------------------------
" 文字コード関連
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
"-----------------------------------------------------------------------------
" 編集関連
set title
set hidden
set backspace=indent,eol,start
set smartindent
"-----------------------------------------------------------------------------
" no mouse
set mouse=
"-----------------------------------------------------------------------------
" 検索関連
set ignorecase
set smartcase
set wrapscan
set noincsearch
"-----------------------------------------------------------------------------
" 装飾関連
syntax on
set nonumber
"set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<,eol:<
"タブの左側にカーソル表示
set listchars=tab:\ \ 
set list
set tabstop=4
set shiftwidth=4
set expandtab
set showcmd
set showmatch
let loaded_matchparen = 1
set hlsearch
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"colorscheme desert

"-----------------------------------------------------------------------------
" for objective-c
autocmd BufNewFile,BufRead *.h,*.m set filetype=objc
let objc_syntax_for_h = 1
set complete+=k~/.vim/keyword/objc_keyword

"-----------------------------------------------------------------------------
runtime! macros/matchit.vim

augroup myfiletypes
	" Clear old autocmds in group
	autocmd!
	" autoindent with two spaces, always expand tabs
	autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et

	autocmd FileType python set autoindent smartindent tabstop=8 expandtab shiftwidth=2 softtabstop=2
augroup END

"-----------------------------------------------------------------------------
" ファイルタイプ関連を有効にする
filetype plugin indent on
"-----------------------------------------------------------------------------
"バッファ移動用キーマップ
" F2: 前のバッファ
" F3: 次のバッファ
" F4: バッファ削除
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
"表示行単位で行移動する
nnoremap j gj
nnoremap k gk
"フレームサイズを怠惰に変更する
map <kPlus> <C-W>+
map <kMinus> <C-W>-
