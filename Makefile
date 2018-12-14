LUALATEX ?= lualatex
MAKEGLOSSARIES ?= makeglossaries

pdf:
	$(MAKE) tex
	$(MAKE) glossary
	$(MAKE) tex

tex:
	$(LUALATEX) --jobname=markless -file-line-error -shell-escape --synctex=1 -interaction=nonstopmode "\input" markless.tex

glossary:
	$(MAKEGLOSSARIES) markless
