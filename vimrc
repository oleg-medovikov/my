"" Last update: 04.04.2021 21:35

call plug#begin('~/.vim/plugged')

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"цветовая схема
Plug 'morhetz/gruvbox'
"пометка о редактировании строки
Plug 'airblade/vim-gitgutter'
Plug 'sirtaj/vim-openscad'
"Plug 'lervag/vimtex'
"Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'plasticboy/vim-markdown'
call  plug#end()

map <C-v> I\section{}<enter><esc>
imap ii <esc>
imap 33 #
imap -- —
nnoremap j gj
nnoremap k gk

map <C-p> o<esc><enter>

set nocompatible " отключить режим совместимости с классическим Vi
set scrolloff=3 " сколько строк внизу и вверху экрана показывать при скроллинге
"set background=light
set wrap " (no)wrap - динамический (не)перенос длинных строк
set linebreak " переносить целые слова
set hidden " не выгружать буфер когда переключаешься на другой
set mousehide " скрывать мышь в режиме ввода текста
set showcmd " показывать незавершенные команды в статусбаре (автодополнение ввода)
set showmatch " показывать первую парную скобку после ввода второй
set autoread " перечитывать изменённые файлы автоматически
set t_Co=256 " использовать больше цветов в терминале
set confirm " использовать диалоги вместо сообщений об ошибках

set  spell spelllang=ru_yo,en_us
"" Автоматически перечитывать конфигурацию VIM после сохранения
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

"" Формат строки состояния
" fileformat - формат файла (unix, dos); fileencoding - кодировка файла;
" encoding - кодировка терминала; TYPE - тип файла, затем коды символа под курсором;
" позиция курсора (строка, символ в строке); процент прочитанного в файле;
" кол-во строк в файле;
"set statusline=%F%m%r%h%w\ [FF,FE,TE=%{&fileformat},%{&fileencoding},%{&encoding}\]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

"" Подсвечивать табы и пробелы в конце строки
set list " включить подсветку
set listchars=tab:>-,trail:- " установить символы, которыми будет осуществляться подсветка
set tabstop=4 "количество символов на таб



"Проблема красного на красном при spellchecking-е решается такой строкой в .vimrc
highlight SpellBad ctermfg=Black ctermbg=Red
au BufWinLeave *.* silent mkview " при закрытии файла сохранить 'вид'
au BufWinEnter *.* silent loadview " при открытии - восстановить сохранённый

set backspace=indent,eol,start " backspace обрабатывает отступы, концы строк
set noswapfile " не использовать своп-файл (в него скидываются открытые буферы)
set browsedir=current
set visualbell " вместо писка бипером мигать курсором при ошибках ввода

set clipboard=unnamed " во избежание лишней путаницы использовать системный буфер обмена вместо буфера Vim
set backup " включить сохранение резервных копий
set title " показывать имя буфера в заголовке терминала
set history=128 " хранить больше истории команд
set undolevels=2048 " хранить историю изменений числом N
"set virtualedit=all " позволяет курсору выходить за пределы строки
set whichwrap=b,<,>,[,],l,h " перемещать курсор на следующую строку при нажатии на клавиши вправо-влево и пр.

syntax on " включить подсветку синтаксиса
"НАСТРОЙКИ ПЕРЕКЛЮЧЕНИЯ РАСКЛАДОК КЛАВИАТУРЫ
"" Взято у konishchevdmitry
set keymap=russian-jcukenwin " настраиваем переключение раскладок клавиатуры по <C-^>
set iminsert=0 " раскладка по умолчанию - английская
set imsearch=0 " аналогично для строки поиска и ввода команд
function! MyKeyMapHighlight()
   if &iminsert == 0 " при английской раскладке статусная строка текущего окна будет серого цвета
      hi StatusLine ctermfg=White guifg=White
   else " а при русской - зеленого.
      hi StatusLine ctermfg=DarkRed guifg=DarkRed
   endif
endfunction
call MyKeyMapHighlight() " при старте Vim устанавливать цвет статусной строки
autocmd WinEnter * :call MyKeyMapHighlight() " при смене окна обновлять информацию о раскладках

" плагин NERDTree - дерево каталогов)
map <C-f> :NERDTreeToggle<cr>
vmap <C-f> <esc>:NERDTreeToggle<cr>i
imap <C-f> <esc>:NERDTreeToggle<cr>i

"" Переключение табов (вкладок) (rxvt-style)
map <C-h> :tabprevious<cr>
nmap <C-h> :tabprevious<cr>
imap <C-h> <ESC>:tabprevious<cr>i
map <C-l> :tabnext<cr>
nmap <C-l> :tabnext<cr>
imap <C-l> <ESC>:tabnext<cr>i
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>



colorscheme gruvbox


"НАСТРОЙКИ РАБОТЫ С ФАЙЛАМИ
"Кодировка редактора (терминала) по умолчанию (при создании все файлы приводятся к этой кодировке)
if has('win32')
   set encoding=cp1251
else
   set encoding=utf-8
   set termencoding=utf-8
endif
" формат файла по умолчанию (влияет на окончания строк) - будет перебираться в указанном порядке
set fileformat=unix
" варианты кодировки файла по умолчанию (все файлы по умолчанию сохраняются в этой кодировке)
set fencs=utf-8,cp1251,koi8-r,cp866
"" Перед сохранением .vimrc обновлять дату последнего изменения
autocmd! bufwritepre $MYVIMRC call setline(1, '"" Last update: '.strftime("%d.%m.%Y %H:%M"))
syntax on " включить подсветку синтаксиса
"" Применять типы файлов
filetype on
filetype plugin on

"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview


filetype indent on
autocmd BufEnter *.txt,*.md set filetype=text
autocmd Filetype text setlocal tw=80 wrapmargin=0
autocmd Filetype text setlocal colorcolumn=81
autocmd Filetype text setlocal nolist noai
autocmd Filetype text setlocal expandtab ts=3 sw=3
" Эирлайн
let g:airline_section_b=''
let g:airline_skip_empty_sections=1

hi SpellBad cterm=bold,italic ctermfg=black ctermbg=None
hi SpellCap cterm=None ctermfg=black ctermbg=None
hi SpellRare cterm=None ctermfg=black ctermbg=None
hi SpellLocal cterm=None ctermfg=black ctermbg=None




