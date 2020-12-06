kobo.html: out.md
	pandoc $< -o $@ --toc-depth=1 --template ./template/template.html --standalone --mathjax --toc --toc-depth 2

out.md: KoboReader.sqlite
	cabal run kobonotes -- KoboReader.sqlite out.md

clean:
	rm -f out.md kobo.html
