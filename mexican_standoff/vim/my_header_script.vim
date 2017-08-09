let s:_42 = [
			\"        :::      ::::::::",
			\"      :+:      :+:    :+:",
			\"    +:+ +:+         +:+  ",
			\"  +#+  +:+       +#+     ",
			\"+#+#+#+#+#+   +#+        ",
			\"     #+#    #+#          ",
			\"    ###   ########.fr    "
			\]

let s:stylebegin = '/*'
let s:styleend = '*/'

""TODO what this variable? How does it works? What's the $ at the end of extensions?
let s:styles = [
			\{
			\'extensions': ['\.c$', '\.h$', '\.cc$', '\.cpp$', '\.hpp$', '\.cs$', '\.css'],
			\'start': '/*', 'end': '*/', 'fill': '*'
			\},
			\{
			\'extensions': ['\Makefile', '\make', '\makefile'],
			\'start': '#', 'end': '#', 'fill': '*'
			\},
			\{
			\'extensions': ['\.htm$', '\.html$', '\.xml$', '\.php$'],
			\'start': '<!--', 'end': '-->', 'fill': '*'
			\},
			\{
			\'extensions': ['\.js$'],
			\'start': '//', 'end': '//', 'fill': '*'
			\},
			\{
			\'extensions': ['\.tex$'],
			\'start': '%', 'end': '%', 'fill': '*'
			\},
			\{
			\'extensions': ['\.ml$', '\.mli$', '\.mll$', '\.mly$'],
			\'start': '(*', 'end': '*)', 'fill': '*'
			\},
			\{
			\'extensions': ['\.vim$', '\.vimrc$', '\.myvimrc$', '\.vimrc'],
			\'start': '"', 'end': '"', 'fill': '*'
			\},
			\{
			\'extensions': ['\.pas$', '\.pascal$', '\.p$', '\.pp$'],
			\'start': '{', 'end': '}', 'fill': '*'
			\}
			\]

function s:get_filetype ()
	""TODO how filename works? and bufname?
	let l:file = fnamemodify(bufname("%"), ':t')

	let s:start = '#'
	let s:end = '#'
	let s:fill = '*'

	for l:style in s:styles
		for l:ext in l:style['extensions']
			if l:file =~ l:ext
				let s:stylebegin = l:style['start']
				let s:styleend = l:style['end']
				let s:fill = l:style['fill']
			endif
		endfor
	endfor
endfunction

let s:lenline = 80
let	s:margin = 5

""TODO get variables from env
""let s:user = $USER42
let s:user = "lfabbro"
let s:mail = $MAIL42

if (s:mail !=# $MAIL42)
	let s:mail = 'lfabbro@student.42.fr'
endif

"if (!s:user)
"	let s:user = 'lfabbro'
"endif

function s:l1 ()
	return (s:stylebegin . repeat(s:fill, s:lenline - strlen(s:stylebegin) * 2) . s:styleend)
endfunction

function s:emptyline ()
	return (s:stylebegin . repeat(' ', s:lenline - strlen(s:stylebegin) * 2) . s:styleend)
endfunction

function s:updateline ()
	let l:text = s:stylebegin . repeat(' ', s:margin - strlen(s:stylebegin)) . "Updated: " . strftime("%Y/%m/%d %H:%M:%S" . " by " . s:user)
	return (l:text . repeat(' ', s:lenline - strlen(l:text) - strlen(s:_42[6]) - s:margin) . s:_42[6] . repeat(' ', s:margin - strlen(s:styleend)) . s:styleend)
endfunction

function s:createline ()
	let l:text = s:stylebegin . repeat(' ', s:margin - strlen(s:stylebegin)) . "Created: " . strftime("%Y/%m/%d %H:%M:%S" . " by " . s:user)
	return (l:text . repeat(' ', s:lenline - strlen(l:text) - strlen(s:_42[5]) - s:margin) . s:_42[5] . repeat(' ', s:margin - strlen(s:styleend)) . s:styleend)
endfunction

function s:emptyline42 (index)
	return (s:stylebegin . repeat(' ', s:lenline - strlen(s:stylebegin) - s:margin - strlen(s:_42[a:index])) . s:_42[a:index] . repeat(' ', s:margin - strlen(s:styleend)) . s:styleend)
endfunction

function s:userline ()
	let l:text = s:stylebegin . repeat(' ', s:margin - strlen(s:stylebegin)) . "By: " . s:user . " <"  . s:mail .  ">"
	return (l:text . repeat(' ', s:lenline - strlen(l:text) - strlen(s:_42[3]) - s:margin) . s:_42[3] . repeat(' ', s:margin - strlen(s:styleend)) . s:styleend)
endfunction

function s:fileline ()
	let l:text = s:stylebegin . repeat(' ', s:margin - strlen(s:stylebegin)) . expand('%:t')
	return (l:text . repeat(' ', s:lenline - strlen(l:text) - strlen(s:_42[1]) - s:margin) . s:_42[1] . repeat(' ', s:margin - strlen(s:styleend)) . s:styleend)
endfunction

function s:updateline_rewrite ()
	if getline(9) =~ s:stylebegin . repeat(' ', 5 - strlen(s:stylebegin)) . "Updated: [0-9]"
		call setline(9, s:updateline())
	endif
endfunction

function s:checkhead ()
	if (getline (1) ==# s:l1 ())
		return (0)
	endif
	if (getline (2) ==# s:emptyline ())
		return (0)
	endif
	if (getline (3) ==# s:emptyline42 (0))
		return (0)
	endif
	if (getline (4) ==# s:fileline ())
		return (0)
	endif
	if (getline(5) ==# s:emptyline42(2))
		return (0)
	endif
	if (getline(6) ==# s:userline())
		return (0)
	endif
	if (getline(7) ==# s:emptyline42(4))
		return (0)
	endif
	if (getline(8) ==# s:createline())
		return (0)
	endif
	if (getline(10) ==# s:emptyline())
		return (0)
	endif
	return (1)
endfunction

function s:swag ()
	call s:get_filetype()

	if (s:checkhead() ==# 1)
		call append(0, "")
		call append(0, s:l1 ())
		call append(0, s:emptyline ())
		call append(0, s:updateline ())
		call append(0, s:createline ())
		call append(0, s:emptyline42(4))
		call append(0, s:userline())
		call append(0, s:emptyline42(2))
		call append(0, s:fileline())
		call append(0, s:emptyline42(0))
		call append(0, s:emptyline ())
		call append(0, s:l1 ())
	endif
endfunction

command Stdswag call s:swag ()
nmap <C-h> :Stdswag<CR>
call s:get_filetype ()
autocmd BufWritePre * call s:updateline_rewrite ()
