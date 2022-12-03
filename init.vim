set number
let g:airline#extensions#tabline#enabled = 1 "开启airline的buffer栏
let g:airline_powerline_fonts = 1
call plug#begin()
	Plug 'scrooloose/nerdtree'                                              "树形结构的文件浏览器
	Plug 'bling/vim-airline'                                                "airline
	Plug 'vim-airline/vim-airline-themes'                                   "airline theme
	Plug 'ryanoasis/vim-devicons'                                           "图标  
	Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim'}           "powerline
	Plug 'tpope/vim-commentary'                                             "注释
	Plug 'mhinz/vim-startify'                                               "开始界面
	Plug 'voldikss/vim-translator'                                          "translate
	Plug 'morhetz/gruvbox'                                                  "colorscheme
	Plug 'joshdick/onedark.vim'                                             "colorscheme
call plug#end()
syntax on
colorscheme onedark
" colorscheme gruvbox
let g:airline_theme='onedark'
