" Vim syntax file
" Language: Runbook
" Maintainer: Billy Kirk
" Latest Revision: 18 Jan 2022

if exists("b:current_syntax")
  finish
endif

syntax region SingleQuotedString start=+\`+ end=+\`+
syntax match EpicadmCode "\$[^#]*"
syntax match RootCode "#\s[^#]*"
syntax match LineComment "#\{2}[^#]*"
syntax match Checkbox "\[x\?\]"
syntax match Header "== .* =="
syntax match Epicadm "epicadm (\$)"
syntax match Root "root (#)"
syntax match HostingRecord "\(CHG\|HRQ\|MWP\|MWC\|INC\)\w*"
syntax match VM "et\d\{4}\w\+"
" syntax match Value ":.*"hs=s+1 contains=HostingRecord
" syntax match Func "d .*\^"hs=s+1,he=e-1 contains=Routine
" syntax match Routine "\^[^(]*"hs=s+1

highlight SingleQuotedString ctermfg=173 guifg=#d19a66
highlight EpicadmCode ctermfg=114 guifg=#98c379
highlight RootCode ctermfg=204 guifg=#e06c75
highlight def link LineComment Comment
highlight Checkbox ctermfg=180 guifg=#e5c07b
highlight Header ctermfg=204 guifg=#e06c75
highlight Epicadm ctermfg=114 guifg=#98c379
highlight Root ctermfg=204 guifg=#e06c75
highlight HostingRecord ctermfg=170 guifg=#c678dd
highlight VM ctermfg=39 guifg=#61afef 
highlight Value ctermfg=173 guifg=#d19a66
" highlight def link Func Identifier
" highlight def link Routine Constant
