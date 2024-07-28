LUALATEX ?= lualatex
MAKEGLOSSARIES ?= makeglossaries
MAKE4HT ?= make4ht

all:
	$(MAKE) pdf
	$(MAKE) html
	$(MAKE) homepage

pdf:
	$(MAKE) tex
	$(MAKE) glossary
	$(MAKE) tex

tex:
	$(LUALATEX) --jobname=markless -file-line-error -shell-escape --synctex=1 -interaction=nonstopmode "\input" markless.tex

glossary:
	$(MAKEGLOSSARIES) markless

html:
	$(MAKE4HT) -l -s markless "markless"

homepage:
	make.lisp
