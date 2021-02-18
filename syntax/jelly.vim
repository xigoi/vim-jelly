if exists("b:current_syntax")
    finish
endif

syntax match jellyNewline '\v¶'
syntax match jellyChainSeparator '\v[øµðɓ)]'
syntax match jellyQuick +\v©|ß|¢|Ç|ç|Ñ|ñ|£|Ŀ|ŀ|¦|¡|¿|\/|ƒ|\\|¤|\$|Ɗ|Ʋ|¥|ɗ|ʋ|\#|\?|Ƒ|⁺|\@|\`|\"|\'|þ|\{|\}|€|Þ|Ɲ|Ƥ|ƙ|ɼ|ƭ|Ɱ|Ð¡|Ð¿|ÐƤ|Ƈ|Ðḟ|ÐL|Ƭ|ÐḶ|ÐṂ|ÐṀ|Ðe|Ðo+

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
highlight link jellyQuick Function
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

let b:current_syntax = "arturo"
