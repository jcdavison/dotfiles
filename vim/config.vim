" Hide the vim splash screen
set shortmess+=I

syntax on
filetype plugin indent on

set hidden
set nowrap        " don't wrap lines
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set tags+=./tags " Set the tag file search order
set tags+=gems.tags
set grepprg=ack   " Use Ack instead of grep
set nobackup      " no backup files
set nowritebackup " only in case you don't want a backup file while editing
set noswapfile    " no swap files
set wildmenu      " Use wildmenu
set wildmode=longest,list,full " set completion style
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.ico,*.psd,*.pid,*/tmp/*,*.sqlite3,*.ipa,*.xcodeproj/*,*.xib,*.cer,*.icns,public/assets/*,spec/vcr/*,bundler_stubs/*,bin/*
set whichwrap+=<,>,h,l,[,] " let cursor keys wrap around lines
set clipboard=unnamed " use Mac clipboard for yank/paste/etc.
set pumheight =15 " Limit completion popup menu height
" Press Space to toggle highlighting on/off, and show current value.
nnoremap <Space> :set hlsearch! hlsearch?<CR>

" ==========================================
" Code folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default

" ==========================================
" windows and splits
nnoremap <leader>l <ESC>:vsp .<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" See http://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/
" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>
" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%
map <leader>s :split %%

" ==========================================
" ctags

set tags=.tags,gems.tags,.gems.tags
noremap <leader>pt :!ctags -V --languages=ruby -f .gems.tags `gem env gemdir` && ctags -f .tags -RV . <cr>

" ==========================================
" Color scheme settings:

set background=light
colorscheme solarized

" ==========================================
" Vimrc settings:

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" ==========================================
" Command shortcuts:

" Force save files that require root permission
cmap w!! %!sudo tee > /dev/null %

" Make the dot command work with visual mode
:vnoremap . :norm.<CR>

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" ==========================================
" Tab settings

set ts=2 sts=2 sw=2 expandtab "set two spaces by default
" ==========================================
" File settings:
function! TrimWhiteSpace()
  %s/\s\+$//e
:endfunction

"show tab and space characters
set list listchars=tab:» ,trail:·
" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=lightgrey guibg=lightgrey ctermfg=red guifg=lightred
match ExtraWhitespace /\s\+$/

" Remove trailing whitespace with F3
map <silent> <F3> :call TrimWhiteSpace()<CR>``

" ==========================================
" PROMOTE VARIABLE TO RSPEC LET
" ==========================================
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>


" ==========================================
" Filetype Definitions
" ==========================================
autocmd Filetype javascript setlocal et ts=4 sts=4 sw=4
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

autocmd Filetype html setlocal et ts=2 sts=2 sw=2
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

autocmd Filetype css setlocal et ts=2 sts=2 sw=2
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType gitconfig setlocal noet

autocmd BufNewFile,BufRead *_spec.rb, set filetype=ruby.rails.rspec
autocmd BufNewFile,BufRead *.js.coffee.erb, set filetype=eruby.coffee

" ==========================================
" Set proper filetype for spec files
"
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

" ==========================================
" iTerm and screen/tmux settings

if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    " for some reason, doing this directly with 'set ttymouse=xterm2'
    " doesn't work -- 'set ttymouse?' returns xterm2 but the mouse
    " makes tmux enter copy mode instead of selecting or scrolling
    " inside Vim -- but luckily, setting it up from within autocmds
    " works
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
  endif
endif
set ttimeoutlen=50

if &term =~ "xterm" || &term =~ "screen"
  let g:CommandTCancelMap     = ['<ESC>', '<C-c>']
  let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<ESC>OB']
  let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<ESC>OA']
endif
