syntax on 
set tabstop=2
set shiftwidth=2
set showmatch
set noexpandtab

set visualbell
set vb t_vb= 
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

hi DiffText ctermfg=226 ctermbg=16 cterm=bold guifg=#FFFF00 guibg=#000000 gui=bold
hi DiffChange ctermfg=none ctermbg=237 cterm=none guifg=NONE guibg=#3A3A3A gui=none
hi DiffAdd ctermfg=231 ctermbg=22 cterm=bold guifg=#FFFFFF guibg=#005F00 gui=bold
hi DiffDelete ctermfg=231 ctermbg=52 cterm=bold guifg=#FFFFFF guibg=#5F0000 gui=bold

:set smartindent
:imap ` <c-n>
:inoremap !!~ `

set autowrite

map D "_dd

map <F2> :up<CR>
imap <F2> <ESC><F2>i
map <F11> :set paste<CR>i
imap <F11> <F2><ESC><F11>i
map <F12> :set nopaste<CR>
imap <F12> <F2><ESC><F12>i

" ----

map <F8> :wall<CR>:!clear<CR>:make<CR>
imap <F8> <ESC><F8>i

"inoremap - _
"inoremap _ -

" access to normal > char (not ->)
inoremap !!gr >
inoremap !!lt <
inoremap !!> >
inoremap !!< <
imap !!js <ESC>:set paste<CR>i<script type="text/javascript"><CR>//<![CDATA[<CR><CR>//]]><CR></script><ESC>:set nopaste<CR>i

inoremap · ->

map <F9> <F2>:wall<CR>:!clear<CR>:make run<CR>
imap <F9> <F2><ESC><F9>i
map <F10> <F2>:wall<CR>:!clear<CR>:!make run<CR>
imap <F10> <F2><ESC><F10>i
"map <F12> <F2>:wall<CR>:!clear<CR>:!./rebuild_one.sh % 1<CR>
"imap <F12> <F2><ESC><F12>i
map <F7> :wall<CR>:!clear<CR>:!make test<CR>
imap <F7> <ESC><F7>i

map <F5> <F2>:bn<CR>
imap <F5> <ESC><F5>i
map <S-F5> <F2>:bp<CR>
imap <S-F5> <ESC><S-F5>i
map <F6> :up<CR>:A<CR>
imap <F6> <ESC><F6>i
map <F4> :w<CR>:bd<CR>
imap <F4> <ESC><F4>i
map Z :qa!<CR>

map <S-F2> :mks ses.vimses<CR>
imap <S-F2> <ESC><S-F2>i

map <S-F3> :source ses.vimses<CR>
imap <S-F3> <ESC><S-F3>i

" if filereadable("ses.vimses") | source ses.vimses | bn | bp | endif

 
" 
" if filereadable("SConstruct") | set makeprg=scons | endif
"
 
:hi Comment term=bold ctermfg=blue guifg=#80a0ff gui=bold
:hi Operator term=bold ctermfg=white cterm=bold
:hi Type cterm=bold ctermfg=green
:hi Statement cterm=bold ctermfg=lightred
:hi Delimiter cterm=bold ctermfg=red

:imap <c-t> <?php __('') ?><esc>hhhhi
inoremap !!f function () {<CR>}<UP><END><LEFT><LEFT><LEFT><LEFT>
inoremap !!F void () {<CR>}<UP><END><LEFT><LEFT><LEFT><LEFT>

":imap <c-tab> <tab>
":imap <s-tab> <c-n>
":imap \ <c-n>
":inoremap !!] \

:inoremap !!# // #####################################################################<CR>#####################################################################<CR>#####################################################################
:inoremap !!3 // #####################################################################
:inoremap !!= // =====================================================================
:inoremap !!- // ---------------------------------------
:inoremap !!. // ---------
:inoremap !!* // ****** 
:inoremap !!vv virtual void
:inoremap !!cpp #include <iostream><CR>using namespace std;<CR><CR>int main() { <CR>  return 0;<CR>}
:inoremap //<= // <========= 
:inoremap //<- // <------ 
:inoremap ..R return ; // <--- RET  <ESC>hhhhhhhhhhhhhhi

:inoremap !p <?php   ?><ESC>hhhi
:inoremap !sv $this->set_var(<ESC>

:inoremap !12 <ESC>:r !date +"\%Y-\%m-\%d \%H:\%M:\%S "<CR>i

:inoremap ..v virtual
:inoremap ..V virtual void
:inoremap ..r return
:inoremap ..s $this->set_var();<ESC>hi

:source ~/bin/vim/a.vim
:source ~/bin/vim/minibufexpl.vim

:set foldmethod=indent
:set foldminlines=2000

:let g:miniBufExplorerMoreThanOne = 2
:let g:miniBufExplMapCTabSwitchBufs = 1
:let g:miniBufExplMapWindowNavVim = 1

:norm zi

map <kMultiply> zi
imap <kMultiply> <ESC>zi i

map <kEnd> :cnext<CR>
imap <kEnd> <ESC><kEnd> i
map <kHome> :cprevious<CR>
imap <kHome> <ESC><kHome> i

:set formatoptions=croql

let g:SeeTabCtermFG="darkblue"
let g:SeeTabCtermBG="none"
let g:SeeTabGuiFG="black"
let g:SeeTabGuiBG="orange" 

:command Utf e ++enc=utf-8

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
	\ exe "normal g'\"" | endif
iab }// } // END: <esc>10h%$?\w\+\s*(<cr>"xy/\s*(<cr>/{<cr>:nohl<cr>%$"xpa

set clipboard=exclude:cons\|linux

" :source ~/bin/vim/showmarks.vim

" set keywordprg=~/cmd/vimhelp.sh


" let g:additionalrc_stop = 1


" http://www.leonerd.org.uk/hacks/vim/additionalrc.html
:source ~/bin/vim/additionalrc.vim

" set softtabstop=2 set shiftwidth=2 set tabstop=2 set expandtab

:let html_use_css = 1



