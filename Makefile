SHELL=/bin/bash
UNAME=$(shell uname)

ifeq ($(UNAME), Darwin)
	LATEX = /Library/TeX/texbin/pdflatex
else
	LATEX = pdflatex
endif

SWEAVE = R --vanilla CMD Sweave

makesweave = mkdir -p $(1); \
	cp $(1).Rnw Sweave.sty $(1); \
	cd $(1); \
	$(SWEAVE) $(1).Rnw; \
	$(LATEX) $(1).tex; \
	cp $(1).pdf ..; \
	cd ..

maketex = mkdir -p $(1); \
	cp $(1).tex $(1); \
	cd $(1); \
	$(LATEX) $(1).tex; \
	cp $(1).pdf ..; \
	cd ..

all: part-1.pdf part-2.pdf part-3.pdf info-1.pdf info-2.pdf finance-1.pdf zkp-1.pdf

clean:
	rm *.{aux,nav,log,out,snm,toc,tex,pdf}

part-1.pdf: part-1.Rnw
	$(call makesweave,part-1)

part-2.pdf: part-2.Rnw
	$(call makesweave,part-2)

part-3.pdf: part-3.Rnw
	$(call makesweave,part-3)

info-1.pdf: info-1.Rnw
	$(call makesweave,info-1)

info-2.pdf: info-2.Rnw
	$(call makesweave,info-2)

finance-1.pdf: finance-1.Rnw
	$(call makesweave,finance-1)

zkp-1.pdf: zkp-1.tex
	$(call maketex,zkp-1)
