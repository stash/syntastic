"============================================================================
"File:        jshint.vim
"Description: Javascript syntax checker - using jshint
"Maintainer:  Martin Grenfell <martin.grenfell at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"============================================================================
if exists("g:loaded_syntastic_javascript_jshint_checker")
    finish
endif
let g:loaded_syntastic_javascript_jshint_checker=1

if !exists("g:syntastic_javascript_jshint_conf")
    let g:syntastic_javascript_jshint_conf = ""
endif

function! SyntaxCheckers_javascript_jshint_IsAvailable()
    return executable('jshint')
endfunction

function! SyntaxCheckers_javascript_jshint_GetLocList()
    let makeprg = syntastic#makeprg#build({
                \ 'exe': 'jshint',
                \ 'post_args': s:Args(),
                \ 'subchecker': 'jshint' })

    let errorformat = '%ELine %l:%c,%Z\\s%#Reason: %m,%C%.%#,%f: line %l\, col %c\, %m,%-G%.%#'
    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat, 'defaults': {'bufnr': bufnr('')} })
endfunction

function s:Args()
    let l:conf = g:syntastic_javascript_jshint_conf

    if exists("b:syntastic_javascript_jshint_conf")
        let l:conf = b:syntastic_javascript_jshint_conf
    elseif exists("t:syntastic_javascript_jshint_conf")
        let l:conf = t:syntastic_javascript_jshint_conf
    elseif exists("w:syntastic_javascript_jshint_conf")
        let l:conf = w:syntastic_javascript_jshint_conf
    endif

    " node-jshint uses .jshintrc as config unless --config arg is present
    return !empty(l:conf) ? ' --config '.l:conf : ''
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'javascript',
    \ 'name': 'jshint'})

