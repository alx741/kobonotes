kobo.html: out.md
	pandoc $< -o $@ --template ./template/template.html --standalone --mathjax --toc --toc-depth 2

out.md:
	./generate.sh KoboReader.sqlite out.md

clean:
	rm -f out.md kobo.html
