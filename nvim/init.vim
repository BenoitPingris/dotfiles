call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/gv.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'p00f/nvim-ts-rainbow'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ChristianChiarulli/nvcode-color-schemes.vim'

" Plug 'doums/barow'
" Plug 'BenoitPingris/barowLSP'
" Plug 'doums/barowGit'

Plug 'ayu-theme/ayu-vim'
Plug 'ulwlu/elly.vim'

Plug 'evanleck/vim-svelte'
Plug 'bagrat/vim-buffet'
Plug 'akinsho/flutter-tools.nvim'

call plug#end()

set termguicolors
let ayucolor="dark"
colorscheme elly

lua << EOF
require('gitsigns').setup({
  signs = {
    add          = {hl = 'GitGutterAdd'},
    change       = {hl = 'GitGutterChange'},
    delete       = {hl = 'GitGutterDelete'},
    topdelete    = {hl = 'GitGutterDelete'},
    changedelete = {hl = 'GitGutterChange'},
  },
  numhl = false
})
EOF

let mapleader = " "

inoremap jk <Esc>
inoremap <silent> <C-s> <C-o>:w<CR>
nnoremap <C-s> :w<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>u :UndotreeShow<CR>
vnoremap <leader>y "+y
nnoremap <C-b> :NvimTreeToggle<CR>
nnoremap Q <Nop>
nmap <silent>J :bp<CR>
nmap <silent>K :bn<CR>
nmap <silent><C-e> :bd<CR>
nmap <silent><leader>/ :noh<CR>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <C-o>h
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>

tnoremap <silent> <A-d> <C-\><C-n>:lua require('terminal').toggle()<CR>
tnoremap <silent> jk <C-\><C-n>
nnoremap <silent> <A-d> :lua require('terminal').toggle()<CR>

nmap <C-p> :Files<CR>
nmap <A-f> :Ag<CR>
nmap <leader>p :Buffers<CR>

let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_follow = 1

command! GitPush Git -c push.default=current push
