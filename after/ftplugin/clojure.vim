" Ensure dot (.) is not part of a word in Clojure buffers so foo.bar.baz is three words
" This file runs after the default clojure ftplugin

" Remove dot from iskeyword for this buffer only
setlocal iskeyword-=.

" Optional: you might also want to treat / as a word separator (namespaces):
" setlocal iskeyword-=/

" Verify: in a Clojure file, place cursor on foo.bar.baz and press 'w' or use * to see separate words.
