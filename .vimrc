" Gvim geometry used to be set in .Xdefaults ?
set lines=25 columns=80

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
set cindent 
" Turn off cindent for ...
" ... LaTeX files
autocmd BufEnter *.tex set nocindent
" ... text files
autocmd BufEnter *.txt set nocindent
" ... README files
autocmd BufEnter README* set nocindent
" ... src files
autocmd BufEnter *.src set nocindent
set cinoptions=p0,t0,+4,(0,u4,U1,:0
" formatoptions:
" c	Auto-wrap comments using textwidth, inserting the current comment
" 	leader automatically.
" r	Automatically insert the current comment leader after hitting
" 	<Enter> in Insert mode.
" o	Automatically insert the current comment leader after hitting 'o' or
" 	'O' in Normal mode.
" q	Allow formatting of comments with "gq".
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
"	"highlight Normal guibg=White guifg=Black
"	highlight Normal guibg=White guifg=DarkCyan	
"else
"	highlight Normal guibg=Wheat guifg=Brown	
"endif
"
" because the &readonly setting is local to a buffer, and isn't set until
" a buffer is loaded. this .vimrc file is parsed before any buffers are
" loaded. Hook into the BufReadPost autocommand, which is executed after
" reading a file into a buffer:
autocmd BufReadPost *
    \ if &readonly
    \|	highlight Normal guibg=White guifg=DarkCyan	
    \| else
    \|	highlight Normal guibg=Wheat guifg=Brown	
    \|endif

" Mappings to toggle folds
" With the following in your vimrc, you can toggle folds open/closed by pressing
" F9. In addition, if you have :set foldmethod=manual, you can visually select
" some lines, then press F9 to create a fold.
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Note you should have ~/.vim/plugin/autoload_cscope.vim present
" Vim global plugin for autoloading cscope databases.
" so you can invoke vim in subdirectories and still get cscope.out loaded.

" Below overridden by plugin above?
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
"if has("cscope")
"
"    """"""""""""" Standard cscope/vim boilerplate
"
"    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
"    set cscopetag
"
"    " check cscope for definition of a symbol before checking ctags: set to 1
"    " if you want the reverse search order.
"    set csto=0
"
"    " add any cscope database in current directory
"    if filereadable("cscope.out")
"        cs add cscope.out  
"    " else add the database pointed to by environment variable 
"    elseif $CSCOPE_DB != ""
"        cs add $CSCOPE_DB
"    endif
"
"    " show msg when any other cscope db added
"    set cscopeverbose  
"
"
"    " From http://cscope.sourceforge.net/cscope_maps.vim
"    """"""""""""" My cscope/vim key mappings
"    "
"    " The following maps all invoke one of the following cscope search types:
"    "
"    "   's'   symbol: find all references to the token under cursor
"    "   'g'   global: find global definition(s) of the token under cursor
"    "   'c'   calls:  find all calls to the function name under cursor
"    "   't'   text:   find all instances of the text under cursor
"    "   'e'   egrep:  egrep search for the word under cursor
"    "   'f'   file:   open the filename under cursor
"    "   'i'   includes: find files that include the filename under cursor
"    "   'd'   called: find functions that function under cursor calls
"    "
"    " Below are three sets of the maps: one set that just jumps to your
"    " search result, one that splits the existing vim window horizontally and
"    " diplays your search result in the new window, and one that does the same
"    " thing, but does a vertical split instead (vim 6 only).
"    "
"    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
"    " unlikely that you need their default mappings (CTRL-\'s default use is
"    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
"    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
"    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
"    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
"    " (which also maps to CTRL-/, which is easier to type).  By default it is
"    " used to switch between Hebrew and English keyboard mode.
"    "
"    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
"    " that searches over '#include <time.h>" return only references to
"    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
"    " files that contain 'time.h' as part of their name).
"
"
"    " To do the first type of search, hit 'CTRL-\', followed by one of the
"    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
"    " search will be displayed in the current window.  You can use CTRL-T to
"    " go back to where you were before the search.  
"    "
"
"    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
"    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
"    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
"    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
"    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
"    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
"    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	
"
"    " Using 'CTRL-spacebar' (interpreted as CTRL-@ by vim) then a search type
"    " makes the vim window split horizontally, with search result displayed in
"    " the new window.
"    "
"    " (Note: earlier versions of vim may not have the :scs command, but it
"    " can be simulated roughly via:
"    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	
"
"    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
"    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
"    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
"    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
"    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
"    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
"    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
"    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	
"
"
"    " Hitting CTRL-space *twice* before the search type does a vertical 
"    " split instead of a horizontal one (vim 6 and up only)
"    "
"    " (Note: you may wish to put a 'set splitright' in your .vimrc
"    " if you prefer the new window on the right instead of the left
"
"    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
"    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
"    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
"    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
"    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
"    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
"    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
"    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
"
"
"    """"""""""""" key map timeouts
"    "
"    " By default Vim will only wait 1 second for each keystroke in a mapping.
"    " You may find that too short with the above typemaps.  If so, you should
"    " either turn off mapping timeouts via 'notimeout'.
"    "
"    "set notimeout 
"    "
"    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
"    " with your own personal favorite value (in milliseconds):
"    "
"    "set timeoutlen=4000
"    "
"    " Either way, since mapping timeout settings by default also set the
"    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
"    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
"    " delays as vim waits for a keystroke after you hit ESC (it will be
"    " waiting to see if the ESC is actually part of a key code like <F1>).
"    "
"    "set ttimeout 
"    "
"    " personally, I find a tenth of a second to work well for key code
"    " timeouts. If you experience problems and have a slow terminal or network
"    " connection, set it higher.  If you don't set ttimeoutlen, the value for
"    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
"    "
"    "set ttimeoutlen=100
"
"endif
