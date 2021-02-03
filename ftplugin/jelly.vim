if has('python3')
  function! s:JellyCompressString(string) abort
    python3 << XXX
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
XXX
    return py3eval('Compress.optimal("' .. escape(a:string, '"\') .. '")')
  endfunction
  function! JellyCompress() abort
    let ln = getline('.')
    let lnlen = strchars(ln)
    let start = getcurpos()[4] - 1
    if stridx('”‘’«»', strcharpart(ln, start, 1)) != -1
      let start -= 1
    endif
    while start > 0 && stridx('“”‘’«»', strcharpart(ln, start, 1)) == -1
      let start -= 1
    endwhile
    if strcharpart(ln, start, 1) == '“'
      let end = start + 1
      while end < lnlen - 1 && stridx('“”‘’«»', strcharpart(ln, end, 1)) == -1
        let end += 1
      endwhile
      if strcharpart(ln, end, 1) == '”'
        let inner_string = strcharpart(ln, start + 1, end - start - 1)
        let before = strcharpart(ln, 0, start)
        let after = strcharpart(ln, end + 1, lnlen)
        call setline('.', before .. s:JellyCompressString(inner_string) .. after)
      endif
    endif
  endfunction
else
  function! JellyCompress() abort
    echoerr 'Compression needs Python 3'
  endfunction
endif

nnoremap <leader>jc <cmd>call JellyCompress()<cr>
