kobo.html: out.md
	pandoc $< -o $@ --toc --toc-depth=1 --template ./template/template.html --standalone --mathjax

kobo.pdf: out.md
	pandoc $< -o $@ --toc --toc-depth=1 -H ./template/template.tex --standalone --mathjax -V geometry:margin=2cm

kobo.epub: out.md
	pandoc $< -o $@ --toc --toc-depth=1 --standalone --mathjax

out.md: KoboReader.sqlite
	cabal run kobonotes -- KoboReader.sqlite out.md

clean:
	rm -f out.md kobo.html kobo.pdf kobo.epub
