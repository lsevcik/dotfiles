let mapleader = ","

"""""""""""
" PLUGINS "
"""""""""""

if empty(glob(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"')))
  silent !curl -fLo ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif " Install vim-plug if not found

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif " Run PlugInstall if there are missing plugins

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" SYNTAX HIGHLIGHTING
Plug 'ap/vim-css-color'
Plug 'sheerun/vim-polyglot'
if has('nvim-0.7.0')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

" LANGUAGE SUPPORT
if has('nvim-0.5.0')
    Plug 'mason-org/mason.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'ray-x/lsp_signature.nvim' " show function signature as we are filling them in
endif

" QoL
Plug 'farmergreg/vim-lastplace'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" UI
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
call plug#end()

""""""""""""
" SETTINGS "
""""""""""""

" Terminal settings
	set title
	set mouse=a
	set noshowmode
" Some basics:
	set nocompatible
	filetype plugin indent on
	syntax on
	set clipboard+=unnamedplus
	set encoding=utf-8
	set number
	set tabstop=4 " small tabs
	set softtabstop=4
	set shiftwidth=4
	set expandtab " tab = spaces
	exec "set listchars=tab:\uBB\uBB,trail:\uD7,nbsp:~"
	set list
	set completeopt=menu,menuone,noselect
	set splitbelow splitright
" Search settings
	set showmatch
	set ignorecase
	set hlsearch
	set incsearch
" Enable autocompletion:
	set wildmode=longest,list,full

	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

set foldminlines=5
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"""""""""""""""
" KEYBINDINGS "
"""""""""""""""
lua << EOF
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
  end
EOF

	nnoremap c "_c
	nnoremap C "_C
" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>
" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
	tnoremap <C-w> <C-\><C-n>

" Replace ex mode with gq
	noremap Q gq

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

	nnoremap <leader>o :setlocal spell! spelllang=en_us<CR>
	nnoremap <leader>p :!open <c-r>%<CR><CR>
	nnoremap <leader>n :NERDTreeToggle<CR>
	nnoremap <leader>w :setlocal wrap!<Enter>
	nnoremap <leader><Enter> :noh<Enter>

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


" nvim-treesitter
if has("nvim-0.7.0")
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  auto_install = true,
  ignore_install = { "ipkg" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
}
EOF
endif

if has('nvim-0.5')
lua << EOF
  require "lsp_signature".setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    floating_window_above_cur_line = false, -- try and go below as most vars are above
    handler_opts = {
      border = "rounded"
    }
  })
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
     -- completion = cmp.config.window.bordered(),
     -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  require("mason").setup()

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local servers = {
    'ansiblels',
    'clangd',
    'pyright',
    'rust_analyzer',
    'ts_ls',
    'vimls',
    'yamlls',
    }

  for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
EOF
endif
