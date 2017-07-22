LUALATEX ?= lualatex
MAKEGLOSSARIES ?= makeglossaries

build:
	$(MAKE) build-tex
	$(MAKE) build-glossary
	$(MAKE) build-tex

build-tex:
	$(LUALATEX) --jobname=markless -file-line-error -shell-escape --synctex=1 -interaction=nonstopmode "\input" markless.tex

build-glossary:
	$(MAKEGLOSSARIES) markless
