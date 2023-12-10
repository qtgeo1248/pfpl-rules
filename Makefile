# ===== Usage ================================================================
#
#  Main:
#
#    make                  -- compile all PDFs (both handout and handin)
#    make <filename>.pdf   -- compile specific <filename>.tex file
#
#  Others:
#
#    make again            -- force recompile (for 'undefined references')
#    make clean            -- remove intermediate files
#    make veryclean        -- remove intermediate files & generated PDFs
#    make view             -- open PDFs in system viewer
#    make print            -- send PDFs to default printer
#
# ============================================================================

TARGETS := $(patsubst %.tex,%.pdf,$(wildcard hw*.tex) $(wildcard assn*.tex))

all: $(TARGETS)

# Generalized rule: how to build a .pdf from each .tex
%.pdf: %.tex
	latexmk -pdf -latexoption='-halt-on-error' -latexoption='-interaction=nonstopmode' $<

touch:
	touch *.tex

again: touch all

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb *.synctex.gz *.fdb_latexmk *.fls || true

veryclean: clean
	rm -f *.pdf

view: $(TARGETS)
	if [ "Darwin" = "$(shell uname)" ]; then open $(TARGETS) ; else evince $(TARGETS) ; fi

print: $(TARGETS)
	lpr $(TARGETS)

.PHONY: all again touch clean veryclean view print
