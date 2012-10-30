call pathogen#infect()
call pathogen#helptags()

"filetype on
"filetype plugin indent on

if has('autocmd')
	" Fix python tabs?
	:autocmd filetype python set expandtab

	" Fix empty string ('') syntax highlighting in YAML files
	:autocmd Syntax yaml syn match   yamlConstant        '\'\''
	" Fix yaml tabs
	autocmd FileType yaml        setlocal ai et sta sw=2 sts=2
endif

syntax on
set hidden                          " Buffers get hidden rather than closed
set nocompatible					" Don't be compatible with old-school vi
set ts=4							" set tabstop to 4 spaces (tab width)
set shiftwidth=4					" Prevent tabs from doing double-tab indents
"set showmatch                      " automatically jump back to matched bracket
set cursorline                      " underline the line that cursor is on
set autoindent						" auto-indent after hitting <cr>
set smartindent						" auto-indent after curly brackets
set ignorecase						" ignore case when searching
set smartcase						" don't ignore case when search pattern is mixed case
set incsearch						" search as you type
set hlsearch						" highlight search terms
set wildmode=longest:list,full		" set custom tab auto-completion style
set whichwrap=b,s,h,l,<,>,[,]		" backspace and cursor keys wrap to
set nu								" show lines numbers

" Change parentheses match highlighting to underline/bold
:hi MatchParen cterm=underline,bold ctermbg=none ctermfg=none

"--------------------------------------------------
" Word completion on <TAB>
function! InsertTabWrapper(direction)
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  elseif "backward" == a:direction
    return "\<c-p>"
  else
    return "\<c-n>"
  endif
endfunction

"--------------------------------------------------
" Map the tab keys
inoremap <Tab> <C-R>=InsertTabWrapper("forward")<CR>
" Shift-tab takes a little magic
inoremap <S-Tab> <C-R>=InsertTabWrapper("backward")<CR>
exe 'set t_kB=' . nr2char(27) . '[Z'

"--------------------------------------------------
" Duplicate line with \d or ctrl-d in insert mode
map! <c-d> <esc>yypi
map <leader>d <esc>yyp

"--------------------------------------------------
" ctrl-j and ctrl-k move up and down screen lines rather than file lines
" (for navigating long lines that wrap)
nnoremap <c-j> gj
nnoremap <c-k> gk

"--------------------------------------------------
" File tree on \1, show current file on \2
nnoremap <leader>1 :NERDTreeToggle<CR>
nnoremap <leader>2 :NERDTreeFind<CR>
let NERDTreeMapActivateNode='<CR>'
" Show NERDTree if no file was specified upon opening
if has('autocmd')
	autocmd vimenter * if !argc() | NERDTree | endif
endif

"--------------------------------------------------
" Clear screen also clears search highlighting.
nnoremap <C-L> :nohl<CR><C-L>

"--------------------------------------------------
" Map various keys to create new window splits
nmap <silent> <leader>sh :leftabove vnew<cr>
nmap <silent> <leader>sl :rightbelow vnew<cr>
nmap <silent> <leader>sk :leftabove new<cr>
nmap <silent> <leader>sj :rightbelow new<cr>
nmap <silent> <leader>swh :topleft vnew<cr>
nmap <silent> <leader>swl :botright vnew<cr>
nmap <silent> <leader>swk :topleft new<cr>
nmap <silent> <leader>swj :botright new<cr>
nmap <silent> <leader>t :tabnew<cr>

"--------------------------------------------------
" \n toggles line numbers
nmap <silent> <leader>n :set number!<cr>

" Scroll the window next to the current one
"   (especially useful for two-window split)
nmap <silent> <leader>j <c-w>w<c-d><c-w>W
nmap <silent> <leader>k <c-w>w<c-u><c-w>W

"--------------------------------------------------
" \v toggles paste/nopaste
" F7 toggles it in insert mode
nnoremap <leader>v :set invpaste paste?<CR>
set pastetoggle=<F7>
" :set showmode " show paste in status - how?

"--------------------------------------------------
" map ; to :
nnoremap ; :

"--------------------------------------------------
" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

"---------------------------------------------------
" Tags file (use ctags)
let Tlist_Use_Right_Window = 1    " tags list on right window
:set tags=.vimtags,~/.vimtags,~/projects/.vimtags
map <silent> <leader>l :Tlist<CR>

"---------------------------------------------------
" Select the last edited/pasted text
nmap gv `[v`]

"---------------------------------------------------
" :w!! executes sudo to write file
cnoreabbrev w!! w !sudo tee % > /dev/null


"---------------------------------------------------
" Colors
if &t_Co >= 256 || has("gui_running")
   colorscheme mustang
endif

"---------------------------------------------------
" Training - map :o to :e
nmap :o :e

"---------------------------------------------------
" \b toggles MiniBufExplorer
map <leader>b :MiniBufExplorer<cr>

"---------------------------------------------------
" PDV PHPDoc Plugin (part of vip plugin)
"source bundle/vip/.vim/php-doc.vim
"inoremap <C-P> :call PhpDocSingle()<CR>i
"nnoremap <C-P> :call PhpDocSingle()<CR>
"vnoremap <C-P> :call PhpDocRange()<CR>

"---------------------------------------------------
" Solarized color scheme
"hi Comment ctermfg=darkgreen
"hi Folded 		ctermbg=black ctermfg=darkred
"set background=light
"let g:solarized_termtrans=1
"colorscheme solarized

"---------------------------------------------------
" Changing text color on non-active status lines to green instead of blue
"hi StatusLineNC     guifg=black       guibg=#202020     gui=NONE      ctermfg=white		ctermbg=darkgray    cterm=NONE
"hi StatusLine     guifg=black       guibg=#202020     gui=NONE      ctermfg=green        ctermbg=darkgray    cterm=NONE

" Custom commands to split, vsplit, or tabnew using the current file's
" directory rather than the cwd
":command! -nargs=1 -complete=custom,CompleteFromCurrentFileDir Csp sp %:p:h/<args>
":command! -nargs=1 -complete=custom,CompleteFromCurrentFileDir Cvs vs %:p:h/<args>
":command! -nargs=1 -complete=custom,CompleteFromCurrentFileDir Ctabnew tabnew %:p:h/<args>

":    function! CompleteFromCurrentFileDir(ArgLead, CmdLine, CursorPos)
":       let CompletionPath = expand("%:p:h")
":"        let files = split(glob(CompletionPath . '*'), "\n")
":        let files = split(globpath(CompletionPath, '*'), "\n")
":        call map(files, 'substitute(v:val, ".*/", "", "")')
":        return join(files, "\n")
":"       return files
":    endfunction

