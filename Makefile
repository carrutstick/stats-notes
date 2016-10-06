SHELL=/bin/bash
UNAME=$(shell uname)

ifeq ($(UNAME), Darwin)
	LATEX = /usr/local/texlive/2014/bin/x86_64-darwin/pdflatex
else
	LATEX = pdflatex
endif

SWEAVE = R --vanilla CMD Sweave

makedoc = mkdir -p $(1); \
	cp $(1).Rnw Sweave.sty $(1); \
	cd $(1); \
	$(SWEAVE) $(1).Rnw; \
	$(LATEX) $(1).tex; \
	cp $(1).pdf ..; \
	cd ..

all: part-1.pdf part-2.pdf part-3.pdf info-1.pdf

clean:
	rm *.{aux,nav,log,out,snm,toc,tex,pdf}

part-1.pdf: part-1.Rnw
	$(call makedoc,part-1)

part-2.pdf: part-2.Rnw
	$(call makedoc,part-2)

part-3.pdf: part-3.Rnw
	$(call makedoc,part-3)

info-1.pdf: info-1.Rnw
	$(call makedoc,info-1)
