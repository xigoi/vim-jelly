if exists('b:current_syntax')
    finish
endif

syntax match jellyNewline '\v¶'
syntax match jellyChainSeparator '\v[øµðɓ)]'
syntax match jellyOneByteQuick '\v[©ß¢ÇçÑñ£Ŀŀ¦¡¿/ƒ¤$ƊƲ¥ɗʋ#?Ƒ⁺@`"'þ{}€ÞƝƤƙɼƭⱮ]'
if get(g:, 'jelly_caird_fork', v:false)
    syntax match jellyOneByteQuick '\v[)ƁƘɱɲƥȤȥ]'
endif
syntax match jellyTwoByteQuick '\vÐ.'
syntax match jellyTwoByteLink '\v[ØÆæŒœ].'

" Literals {{{
syntax match jellyNumber '\v[0-9-.ıȷ]+'
syntax match jellyOneCharString '\v”.'
syntax match jellyTwoCharString '\v⁾..'
syntax match jellyTwoDigitCompressedInt '\v⁽..'
syntax match jellyString '\v“[^‘’«»]{-}”'
syntax match jellyCompressedString '\v“[^”‘’«]{-}»'
syntax match jellyCodepageList '\v“[^”’«»]{-}‘'
syntax match jellyCompressedInt '\v“[^”‘«»]{-}’'
syntax match jellyUnassignedLiteral '\v“[^”‘’»]{-}«'
" }}}

" Highlight links {{{
highlight link jellyNewline Delimiter
highlight link jellyChainSeparator Keyword
highlight link jellyOneByteQuick Function
highlight link jellyTwoByteQuick Function
highlight link jellyNumber Float
highlight link jellyOneCharString String
highlight link jellyTwoCharString String
highlight link jellyTwoDigitCompressedInt Number
highlight link jellyString String
highlight link jellyCompressedString String
highlight link jellyCodepageList Constant
highlight link jellyCompressedInt Number
highlight link jellyUnassignedLiteral Error
" }}}

let b:current_syntax = 'jelly'
