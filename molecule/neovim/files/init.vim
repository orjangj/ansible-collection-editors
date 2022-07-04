"============= Settings =============
set nocompatible        "Necessary for cool vim things
set noswapfile          "Disable swap files permanently
set title               "Show filename in the window titlebar
set number              "Show line numbers
set relativenumber      "Show line numbers relative to cursor
set encoding=utf-8      "Set encoding
set ruler               "Add ruler at the bottom of vim
set cursorline          "Highlight cursor line
set backspace=indent,eol,start  "Make backspace work like most text editors
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --follow
set grepformat=%f:%l:%c:%m,%f:%l:%m
syntax enable           "Keep theme colors since syntax on overrules them

filetype off

"Plugin management
call plug#begin()

Plug 'junegunn/fzf', { 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'

call plug#end()

"---- Fzf ----
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fr :Rg<CR>
nnoremap <silent> <Leader>fl :BLines<CR>
"Do not consider filename as a match in Neovim
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"---- Airline ----
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

