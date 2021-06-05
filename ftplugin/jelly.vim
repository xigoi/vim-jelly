let s:digraph_table = {
      \   '**': '×', '//': '÷',
      \   '++': '‘', '--': '’',
      \   '0n': '¤',
      \   '12': '½',
      \   '2d': '¥', '3d': 'ɗ', '4d': 'ʋ',
      \   '2m': '$', '3m': 'Ɗ', '4m': 'Ʋ',
      \   '<<': '«', '>>': '»',
      \   '??': '¿', '!!': '¡',
      \   'O/': 'Ø', 'AE': 'Æ', 'ae': 'æ', 'OE': 'Œ', 'oe': 'œ', 'D-': 'Ð',
      \   'OR': '®', 'OC': '©',
      \   '\n': '¶',
      \   '^+': '⁺', '^-': '⁻', '^=': '⁼', '^(': '⁽', '^)': '⁾',
      \   '^0': '°', '^1': '¹', '^2': '²', '^3': '³', '^4': '⁴',
      \   '^5': '⁵', '^6': '⁶', '^7': '⁷', '^8': '⁸', '^9': '⁹',
      \   'cn': 'ø', 'cm': 'µ', 'cd': 'ð', 'cr': 'ɓ',
      \   'ii': 'ı', 'jj': 'ȷ',
      \   'in': '£', 'im': 'Ŀ', 'id': 'ŀ',
      \   'ml': '€', 'mr': 'Ɱ',
      \   'nm': 'Ñ', 'nd': 'ñ',
      \   'no': '¬',
      \   'pn': '¢', 'pm': 'Ç', 'pd': 'ç',
      \   'ss': 'ß', 'th': 'þ', 'TH': 'Þ',
      \   '||': '¦',
      \}
let s:upper_underdot_letters = 'ẠḄ ḌẸ  ḤỊ ḲḶṂṆỌ  ṚṢṬỤṾẈ ỴẒ'
let s:lower_underdot_letters = 'ạḅ ḍẹ  ḥị ḳḷṃṇọ  ṛṣṭ  ẉ ỵẓ'
let s:upper_overdot_letters  = 'ȦḂĊḊĖḞĠḢİ  ĿṀṄȮṖ ṘṠṪ  ẆẊẎŻ'
let s:lower_overdot_letters  = 'ȧḃċḋėḟġḣ   ŀṁṅȯṗ ṙṡṫ  ẇẋẏż'
let s:upper_hook_letters     = ' ƁƇƊ ƑƓ   Ƙ ⱮƝ Ƥ   Ƭ Ʋ   Ȥ'
let s:lower_hook_letters     = ' ɓƈɗ ƒɠɦ  ƙ ɱɲ ƥʠɼʂƭ ʋ   ȥ'
let s:table_path = expand('<sfile>:p:h:h') .. '/chars'
let s:base250_digits = split('¡¢£¤¥¦©¬®µ½¿€ÆÇÐÑ×ØŒÞßæçðıȷñ÷øœþ!"#$%&' .. "'" .. '()*+,-./ 0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~¶°¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ƁƇƊƑƓƘⱮƝƤƬƲȤɓƈɗƒɠɦƙɱɲƥʠɼʂƭʋȥẠḄḌẸḤỊḲḶṂṆỌṚṢṬỤṾẈỴẒȦḂĊḊĖḞĠḢİĿṀṄȮṖṘṠṪẆẊẎŻạḅḍẹḥịḳḷṃṇọṛṣṭ§Äẉỵẓȧḃċḋėḟġḣŀṁṅȯṗṙṡṫẇẋẏż', '\zs')

execute 'command! JellyChars split ' .. s:table_path .. ' | setlocal nomodifiable readonly'

function! s:JellyDigraphToChar() abort
  let before_cursor = strpart(getline('.'), 0, col('.') - 1)
  let digraph = strcharpart(before_cursor, strchars(before_cursor) - 2)
  let first = strcharpart(digraph, 0, 1)
  let second = strcharpart(digraph, 1, 1)
  let char = ''
  if second ==# '.'
    let n_first = char2nr(first)
    if 65 <= n_first && n_first <= 90
      let char = strcharpart(s:upper_underdot_letters, n_first - 65, 1)
    elseif 97 <= n_first && n_first <= 122
      let char = strcharpart(s:lower_underdot_letters, n_first - 97, 1)
    endif
  endif
  if second ==# 'i' && first !=# 'i'
    let n_first = char2nr(first)
    if 65 <= n_first && n_first <= 90
      let char = strcharpart(s:upper_overdot_letters, n_first - 65, 1)
    elseif 97 <= n_first && n_first <= 122
      let char = strcharpart(s:lower_overdot_letters, n_first - 97, 1)
    endif
  endif
  if second ==# "'"
    let n_first = char2nr(first)
    if 65 <= n_first && n_first <= 90
      let char = strcharpart(s:upper_hook_letters, n_first - 65, 1)
    elseif 97 <= n_first && n_first <= 122
      let char = strcharpart(s:lower_hook_letters, n_first - 97, 1)
    endif
  endif
  if char ==# ''
    let char = get(s:digraph_table, digraph, digraph)
  endif
  return "\<bs>\<bs>" .. char
endfunction

function! JellyByteCount() abort
  return 'Whole file: ' .. strchars(join(getline(1, '$'), "\n")) .. ' bytes    Current line: ' .. strchars(getline('.')) .. ' bytes'
endfunction

if has('python3')

  function! JellyCompressString(string) abort
    python3 << endpython3
from jelly import code_page, dictionary
end_len = 2 + max(len(w) for w in dictionary.long) # no need to consider dictionary.short because obviously, it's shorter
dictionary.short = {v: i for i, v in enumerate(dictionary.short)}
dictionary.long  = {v: i for i, v in enumerate(dictionary.long )}
class Compress(list):
  def character(z, c):
    if c in '\n\x7f¶':
      o = 95
    elif ' ' <= c <= '~':
      o = ord(c)-32
    else:
      raise ValueError(c + " is neither printable ASCII nor a linefeed.")
    z = 96*z+o
    z = 3*z+0
    return z
  def dictionary(z, w, nonempty):
    ts = nonempty
    if w[:1] == ' ': w = w[1:]; ts = not ts
    dct = dictionary.short if len(w) < 6 else dictionary.long
    W, sc = (w, 0) if w in dct else (w[:1].swapcase() + w[1:], 1)
    if W not in dct: raise ValueError(w + " isn't in the dictionary.")
    f = ts or sc; j = (2 if sc else 1) if ts else 0; i = dct[W]
    z = len(dct)*z+i
    z = 2*z+int(len(w) < 6)
    if f:
      z = 3*z+j
      z = 3*z+2
    else:
      z = 3*z+1
    return z
  def go(z):
    compressed = []
    while z:
      z, c = divmod(z - 1, 250) # Taken inspiration from Jelly's bijective base conversion algorithm
      compressed.append(code_page[c])
    return '“{0}»'.format(''.join(compressed[::-1]))
  def optimal(str):
    dp = [0] * -~len(str)
    for i in range(len(str) -1,-1,-1):
      dp[i] = Compress.character(dp[i + 1], str[i])
      for j in range(1, min(len(dp) - i, end_len)):
        try:
          dp[i] = min(dp[i], Compress.dictionary(dp[i+j], str[i:i+j], i != 0))
        except ValueError:
          pass
    return min(['“{0}”'.format(str), Compress.go(dp[0])], key=len)
endpython3
    return py3eval('Compress.optimal("' .. escape(a:string, '"\') .. '")')
  endfunction

  function! JellyCompressInteger(num) abort
    return system('jelly eu "ḃ250ịØJ”“;;”’" ' .. a:num)
  endfunction

  function! JellyCompress() abort
    let groupname = synIDattr(synID(line('.'), col('.'), 0), 'name')
    if groupname ==# 'jellyString'
      call search('\v“', 'bcW')
      normal! v
      call search('\v”', 'cW')
      normal! "zy
      let zlen = strchars(@z)
      let str = strcharpart(@z, 1, zlen - 2)
      let last = strcharpart(@z, zlen - 1)
      if last ==# '”'
        execute 'normal! gv"_c' .. JellyCompressString(str) .. "\<esc>"
      endif
    elseif groupname ==# 'jellyNumber'
      call search('\v\d+', 'bcW')
      normal! v
      call search('\v\d+', 'ceW')
      normal! "zy
      execute 'normal! gv"_c' .. JellyCompressInteger(@z) .. "\<esc>"
    endif
  endfunction

else

  function! JellyCompress() abort
    echoerr 'Compression needs Python 3'
  endfunction

endif

nnoremap <buffer>                 <leader>jb :echo JellyByteCount()<cr>
nnoremap <buffer> <silent>        <leader>jc :call JellyCompress()<cr>
nnoremap <buffer>                 <leader>jr :!jelly fun "%:p"<space>
inoremap <buffer> <silent> <expr> <tab>      <SID>JellyDigraphToChar()
