" BASIC SETUP
colorscheme desert
"gvim
if has('gui_running')
  set guifont=Lucida_Console:h14	"set font
  set noeb vb t_vb=			"disable beeps
  set lines=999 columns=999		"maximize window
  set autochdir                         "Automatically change the current directory
endif
"end gvim
let mapleader = ","

set nocompatible	"do not act like vi 
syntax enable
filetype plugin on
set encoding=utf-8
set fileencoding=utf-8
set hidden              " allows you to re-use the same window and switch from an unsaved buffer without saving it first
set diffopt+=vertical    " Always use vertical diffs
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          " Use case insensitive search, except when using capital letters
set smartcase

" Change cursor in insert mode:
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

"relative numbers map
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

map <leader>r :call NumberToggle()<cr>

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
"set laststatus=2
" SET STATUSBAR
"function! GitBranch()
"  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
"endfunction

"function! StatuslineGit()
"  let l:branchname = GitBranch()
"  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
"endfunction

"set statusline=
"set statusline+=%#PmenuSel#
""set statusline+=%{StatuslineGit()}
"set statusline+=%#LineNr#
"set statusline+=\ %f
"set statusline+=%m\
"set statusline+=%=
"set statusline+=%#CursorColumn#
"set statusline+=\ %y
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
"set statusline+=\[%{&fileformat}\]
"set statusline+=\ %p%%
"set statusline+=\ %l:%c
"set statusline+=\

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" escape:
" jk is escape
inoremap jk <esc>

" turn off search highlight
nnoremap <leader>h :nohlsearch<CR>


":nnoremap <silent> <Leader> :<C-u>try \| execute "b" . v:count \| catch \| endtry<CR>
for i in range(1, 99)
    execute printf('nnoremap <Leader>%d :%db<CR>', i, i)
endfor
for i in range(1, 99)
    execute printf('nnoremap <Leader>d%d :Bdelete %d<CR>', i, i)
endfor
" }}}
map <leader>q :bp<cr>
map <leader>w :bn<cr>




" STYLING
" Set tabs to 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set number
set showcmd             " Show command
set cursorline          " highlight cursorline
filetype indent on      " load filetype-specific indent files
filetype plugin on      " load filetype-specific plugin files
set mouse=a             " Use mouse
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**	" ** = search in every subdirectory

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer


" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags




" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list
"

" FILE BROWSING:
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_winsize = 25
" open it when open new file 
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings



" Plugins settings:
"""""""NerdTree
nmap <C-n> :NERDTreeToggle %<CR>

"""""""NerdCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

"""""""""CtrlP
let g:ctrlp_working_path_mode = 'ra'
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_show_hidden = 0

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"     \ }
"let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows


"""""""""Vim-airline
let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 0
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
