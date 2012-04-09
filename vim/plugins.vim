
" ==========================================
" Supertab settings

let g:SuperTabDefaultCompletionType = "context"

" ==========================================
" NERDTree Settings

" Automatically close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" toggle NERDTree with F6
map <silent> <F6> :NERDTreeToggle<CR>
let g:NERDTreeHijackNetrw = 0
let g:loaded_netrw = 1 " Disable netrw
let g:loaded_netrwPlugin = 1 " Disable netrw
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeMinimalUI = 1 " Disable help message
let g:NERDTreeDirArrows = 1

" ==========================================
" Vim pasta settings

let g:pasta_enabled_filetypes = ['ruby', 'javascript', 'css', 'sh', 'html', 'php', 'xml', 'eruby']

" ==========================================
" Gundo Toggle

nnoremap <F5> :GundoToggle<CR>


" ==========================================
" Powerline settings:

set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
let g:Powerline_symbols = 'fancy'

" ==========================================
" RedGreen settings:
map <Leader>] <Plug>MakeGreen " change from <Leader>t to <Leader>]

" ==========================================
" Command-T Settings

" refresh command-t cache when files are written or when vim gains focus
augroup CommandTExtension
  autocmd!
  autocmd FocusGained * CommandTFlush
  autocmd BufWritePost * CommandTFlush
augroup END

" ==========================================
" Yankring Settings
nnoremap <silent> <F11> :YRShow<CR> " Show Yankring with F11

" ==========================================
" Indent Guide Settings
" Show indent guides when editing common formats
autocmd FileType html,css,ruby,eruby,javascript,php,xml call indent_guides#enable()
