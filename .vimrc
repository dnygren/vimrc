" Stop vim from behaving in a strongly vi compatible way
set nocompatible
" Gvim geometry used to be set in .Xdefaults ?
set lines=25 columns=80

" Set the current working directory to be the same as the file being edited.
" With this a :shell drops you into the same directory as the file.
set autochdir

" Pick a font from the Edit menu and then do a :set guifont?
" to determine what it is, then set here and escape spaces with a \
"set guifont=Courier\ New\ 13
"set guifont=Courier\ 10\ Pitch\ 13
"set guifont=-adobe-courier-medium-r-normal--18-180-75-75-m-110-iso8859-1
if has("xfontset")
    " Solaris has this feature so use it to pick font
    " Not sure if this really has anything to do with available fonts
    set guifont=-adobe-courier-medium-r-normal--18-180-75-75-m-110-iso8859-1
else
    " Linux doesn't have this feature
    set guifont=Monospace\ 16
endif

" Turn on syntax highlighting
if has("syntax")
      syntax on
      " Global default syntax of Korn Shell
      let g:is_kornshell = 1
endif

" Display format options on command line
set statusline=[%{&fo}]

" This will highlight all characters greater than 80 columns in grey 
"augroup vimrc_autocmds
"  autocmd BufEnter * highlight OverLength ctermbg=red guibg=gray85
"  autocmd BufEnter * match OverLength /\%81v.*/
"augroup END

" Turn on visual bell to make Vim quiet
set visualbell

" Set cursor position
set ruler

" Set fast tty option since we only use Vim on workstations
set ttyfast

" Set show partial command
set showcmd

" Set highlighting of search matches
set hlsearch

" Expand tabs to spaces
"set expandtab
" Set tabstop to four spaces instead of the default eight
"set tabstop=4
" cstyle seems to count a tab as eight spaces

" Kerberos C Style coding standard settings
" (i.e. BSD/KNF + some SunOS & GNU Standards)
" See https://k5wiki.kerberos.org/wiki/Coding_style
set shiftwidth=4
set tabstop=8
set softtabstop=4
set expandtab
set nosmartindent
" This didn't seem to work well for me because it was hard to specify which
" files cindent shouldn't be applied to. How to not to apply cindent to files
" w/o a suffix etc. D.N. 15 Feb 2022
"set cindent
" Turn off cindent for ...
" ... LaTeX files
"autocmd BufEnter *.tex set nocindent
" ... text files
"autocmd BufEnter *.txt set nocindent
" ... README files
"autocmd BufEnter README* set nocindent
" ... src files
"autocmd BufEnter *.src set nocindent
" This didn't seem to work well for me either.
" Manually turning off cindent worked better. D.N. 16 March 2020
"if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  "filetype plugin indent on
  " ...
"endif
" Only turn on cindent for C/C++
if has("autocmd")
    autocmd BufEnter *.c set cindent
    autocmd BufEnter *.h set cindent
    autocmd BufEnter *.cpp set cindent
    autocmd BufEnter *.hpp set cindent
    autocmd BufEnter *.cc set cindent
    autocmd BufEnter *.cxx set cindent
    autocmd BufEnter *.c++ set cindent
endif
set cinoptions=p0,t0,+4,(0,u4,U1,:0
" formatoptions:
" c     Auto-wrap comments using textwidth, inserting the current comment
"       leader automatically.
" r     Automatically insert the current comment leader after hitting
"       <Enter> in Insert mode.
" o     Automatically insert the current comment leader after hitting 'o' or
"       'O' in Normal mode.
" q     Allow formatting of comments with "gq".
set formatoptions=croq
set comments=sr:/*,mb:*,ex:*/,://
set textwidth=80

" Set toolbar to use icons and text
"set tb=icons,text

" Set print command to use US letter size rather than default European A4
set printoptions=paper:letter

" vim 7.0+ features
if version >= 700

    " activate spellcheck, toggle with F6, starts ON
    setlocal spell spelllang=en_us
    noremap <silent> <F6> :set spell!<CR>
    inoremap <silent> <F6> <c-o>:set spell!<CR>
    " Terminal highlight background color default was un-readable red. 
    highlight SpellBad ctermbg=Yellow

    " turn on omni-completion when available
    au Filetype * if exists('&omnifunc') && &omnifunc == "" |
    \ set ofu=syntaxcomplete#Complete |
    \ endif

endif

" If you want to put swap files in a fixed place instead of the
" same directory as the file being edited use:
" (for Unix)
" echo $version
" echo expand("$version")
" if expand("$CUE_HOSTNAME")=="nygren"
" Double slashes at end makes a unique file name from path
    set dir=/var/tmp//
" endif
" I did this because the Solaris CDE File Manager would stutter
" if opened to the same directory as a file I opened to edit.
"
" (for MS-DOS and Win32)
" set dir=c:\\tmp\\

" Use a different color background if file is opened in
" readonly mode.(VIC-20 colors used to remind me!)
" The below does not work by itself
"
"if &readonly
"   "highlight Normal guibg=White guifg=Black
"   highlight Normal guibg=White guifg=DarkCyan
"else
"   highlight Normal guibg=Wheat guifg=Brown
"endif
"
" because the &readonly setting is local to a buffer, and isn't set until
" a buffer is loaded. this .vimrc file is parsed before any buffers are
" loaded. Hook into the BufReadPost autocommand, which is executed after
" reading a file into a buffer:
autocmd BufReadPost *
    \ if &readonly
    \| highlight Normal guibg=White guifg=DarkCyan
    \| else
    \| highlight Normal guibg=Wheat guifg=Brown
    \|endif

" Mappings to toggle folds
" With the following in your vimrc, you can toggle folds open/closed by pressing
" F9. In addition, if you have :set foldmethod=manual, you can visually select
" some lines, then press F9 to create a fold.
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Note you should have ~/.vim/plugin/cscope_helper.vim present, which is a
" Vim global plugin for autoloading cscope databases, so you can invoke Vim in
" subdirectories and still get cscope*out loaded.
set csre
