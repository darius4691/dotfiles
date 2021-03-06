" ______  _______  ______ _____ _     _ _______
" |     \ |_____| |_____/   |   |     | |______
" |_____/ |     | |    \_ __|__ |_____| ______|
" 
" neovim configuration files

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Basic Settins                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable                               " syntax highlight
set number                                  " show line numbers
set ruler
set ttyfast                                 " terminal acceleration
set tabstop=4                               " 4 whitespaces for tabs visual presentation
set shiftwidth=4                            " shift lines by 4 spaces
set smarttab                                " set tabs for a shifttabs logic
set expandtab                               " expand tabs into spaces
set autoindent                              " indent when moving to the next line while writing code
set cursorline                              " shows line under the cursor's line
set showmatch                               " shows matching part of bracket pairs (), [], {}
set enc=utf-8                               " utf-8 by default
set backspace=indent,eol,start              " backspace removes all (indents, EOLs, start) What is start?
set scrolloff=10                            " let 10 lines before/after cursor during scroll
set clipboard=unnamed                       " use system clipboard
set hidden                                  " TextEdit might fail if hidden is not set. 
set nobackup                                " Some servers have issues with backup files, see #649.
set nowritebackup
set cmdheight=2                             " Give more space for displaying messages.
set updatetime=300                          " reduce updatetime (default is 4000 ms = 4 s) leads to noticeable
set shortmess+=c                            " Don't pass messages to ins-completion-menu.
set signcolumn=yes                          " Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
set noshowmode                              " compatible with lightline
set showtabline=2                           " show tab line always
set list                                    " show invisible characters
set listchars=tab:>-,trail:~                " list symbols, extends,precedes are useless if warp is on
set foldnestmax=1                           " only fold top level
set foldmethod=syntax                       "fold by syntax

let g:loaded_python_provider = 0            " disable python2 support
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   vim plug                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Specify a directory for plugins
" - For Neovim: $XDG_DATA_HOME/nvim/plugins
" - Avoid using standard Vim directory names like 'plugin'
let plug_install = 0
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path . 
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path
call plug#begin(stdpath('data') . '/plugged')
" PLUGINS  Make sure you use single quotes
Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc system
Plug 'joshdick/onedark.vim'                     " one dark color theme
Plug 'itchyny/lightline.vim'                    " status line
Plug 'tpope/vim-fugitive'                       " git integration
Plug 'glench/vim-jinja2-syntax'                 " html sub language syntax
Plug 'junegunn/vim-easy-align'                  " align by :EasyAlign
Plug 'michaeljsmith/vim-indent-object'          " <count>ai ii aI iI indent level
Plug '$XDG_DATA_HOME/fzf'                       " fzf integration
Plug 'junegunn/fzf.vim'                         " fzf integration
Plug 'mattn/webapi-vim'                         " required by vim-gist
Plug 'mattn/vim-gist'                           " interactive with github gist
Plug 'tpope/vim-surround'                       " quoting/parenthesizing
Plug 'tpope/vim-repeat'                         " enable repeating supported plugin maps with .
Plug 'diepm/vim-rest-console'                   " REST client
" interactive with jupyter qtconsole
"Plug 'jupyter-vim/jupyter-vim', { 'for': 'python'}
" Initialize plugin system
call plug#end()
if plug_install
    PlugInstall --sync
endif
unlet plug_install
" nvim plug end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Conqure of Completion (coc) settings                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC Extensions
let g:coc_global_extensions = [
    \ 'coc-pairs',
    \ 'coc-explorer',
    \ 'coc-git',
    \ 'coc-python',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-highlight',
    \ 'coc-snippets',
    \ 'coc-sh',
    \ 'coc-go',
    \ ]
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" Make <tab> used for trigger completion, nd jump like VSCode.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  lightline                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! GitStatus() abort
    return get(g:, 'coc_git_status', '')
endfunction

function! CountBuffers() abort
    return 'Buffers: ' . len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'git', 'statusdiagnostic', 'filename', 'method' ]
  \   ],
  \   'right':[
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'component_function': {
  \   'statusdiagnostic': 'StatusDiagnostic',
  \   'git': 'GitStatus',
  \   'blame': 'LightlineGitBlame',
  \ }
\ }
let g:lightline.tabline          = {'left': [['tabs']], 'right': [['buffers']]}
let g:lightline.component_expand = {'buffers': 'CountBuffers'}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               plugin Settings                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gist token
let g:gist_token_file = stdpath('config') . '/gist-vim'
let g:gist_post_private = 1

" fzf buffer
nnoremap <silent> <space>b  :Buffers<cr>
" open files
nnoremap <silent> <space>f  :Files<cr>

"disable curl prograss bar for rest client
let g:vrc_curl_opts = {
    \ '-s': '',
    \ '-i': '',
\}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               color and theme                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" One dark themes
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (has("nvim"))
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif
colorscheme onedark
" enable transparent background
" hi Normal guibg=NONE ctermbg=NONE
