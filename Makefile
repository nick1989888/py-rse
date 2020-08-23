.PHONY : all clean chapters commands crossrefs fixme html links nbspref proposals settings tex-packages

INDEX_HTML=_book/index.html
ALL_HTML=_book/py-novice/index.html _book/r-novice/index.html _book/py-rse/index.html
ALL_PDF=_book/py-novice/py-novice.pdf _book/r-novice/r-novice.pdf _book/py-rse/py-rse.pdf
EXTRA=climate-data data src zipf
GLOSS=${HOME}/glosario

R_NOVICE_FILES=\
  _r-novice.yml \
  r-novice-index.Rmd \
  novice-goals.Rmd \
  r-novice/intro.Rmd \
  r-novice/getting-started.Rmd \
  r-novice/practice.Rmd \
  r-novice/reproducibility.Rmd \
  r-novice/data-manipulation.Rmd \
  r-novice/publishing.Rmd \
  r-novice/objectives.Rmd \
  r-novice/keypoints.Rmd

PY_NOVICE_FILES=\
  _py-novice.yml \
  py-novice-index.Rmd \
  novice-goals.Rmd \
  py-novice/intro.Rmd \
  py-novice/getting-started.Rmd \
  py-novice/data-manipulation.Rmd \
  py-novice/development.Rmd \
  py-novice/objectives.Rmd \
  py-novice/publishing.Rmd \
  py-novice/keypoints.Rmd \
  py-novice/version-control.Rmd

PY_RSE_FILES=\
  _py-rse.yml \
  py-rse-index.Rmd \
  py-rse/bash-basics.Rmd \
  py-rse/bash-advanced.Rmd \
  py-rse/scripting.Rmd \
  py-rse/git-cmdline.Rmd \
  py-rse/git-advanced.Rmd \
  py-rse/automate.Rmd \
  py-rse/config.Rmd \
  py-rse/errors.Rmd \
  py-rse/teams.Rmd \
  py-rse/style.Rmd \
  py-rse/testing.Rmd \
  py-rse/packaging.Rmd \
  py-rse/provenance.Rmd \
  py-rse/finale.Rmd \
  py-rse/install.Rmd \
  py-rse/objectives.Rmd \
  py-rse/keypoints.Rmd \
  py-rse/solutions.Rmd \
  py-rse/yaml.Rmd \
  py-rse/ssh.Rmd

COMMON_FILES=\
  _common.R \
  appendix.Rmd \
  LICENSE.md \
  CONDUCT.md \
  CONTRIBUTING.md \
  glossary.md \
  references.Rmd \
  links.md \
  book.bib \
  preamble.tex

ALL_FILES=${PY_NOVICE_FILES} ${R_NOVICE_FILES} ${PY_RSE_FILES} ${COMMON_FILES}

#-------------------------------------------------------------------------------

all : commands

## commands : show all commands.
commands :
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'

## everything : rebuild all HTML and PDF.
everything : ${INDEX_HTML} ${ALL_HTML} ${ALL_PDF}

##   r-novice : rebuild novice R HTML and PDF.
r-novice : _book/r-novice/index.html _book/r-novice/r-novice.pdf

##   py-novice : rebuild novice Python HTML and PDF.
py-novice : _book/py-novice/index.html _book/py-novice/py-novice.pdf

##   py-rse : rebuild RSE PY HTML and PDF.
py-rse : _book/py-rse/index.html _book/py-rse/py-rse.pdf

#-------------------------------------------------------------------------------

## html           : build all HTML versions.
html : ${ALL_HTML}

##   r-novice-html : build novice R HTML.
r-novice-html : _book/r-novice/index.html

##   py-novice-html : build novice Python HTML.
py-novice-html : _book/py-novice/index.html

##   py-rse-html : build RSE PY HTML.
py-rse-html : _book/py-rse/index.html

_book/py-novice/index.html : ${PY_NOVICE_FILES} ${COMMON_FILES} ${INDEX_HTML}
	rm -f py-novice.Rmd
	cp py-novice-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::gitbook', config_file='_py-novice.yml'); warnings()"

_book/r-novice/index.html : ${R_NOVICE_FILES} ${COMMON_FILES} ${INDEX_HTML}
	rm -f r-novice.Rmd
	cp r-novice-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::gitbook', config_file='_r-novice.yml'); warnings()"

_book/py-rse/index.html : ${PY_RSE_FILES} ${COMMON_FILES} ${INDEX_HTML}
	rm -f py-rse.Rmd
	cp py-rse-index.Rmd index.Rmd
	Rscript -e "options(bookdown.render.file_scope = FALSE); bookdown::render_book(input='index.Rmd', output_format='bookdown::gitbook', config_file='_py-rse.yml'); warnings()"

${INDEX_HTML} : ./_index.html
	mkdir -p _book
	cp ./_index.html ${INDEX_HTML}
	cp -r ${EXTRA} _book

#-------------------------------------------------------------------------------

## pdf : build PDF version.
pdf : ${ALL_PDF} ${INDEX_HTML}

##   r-novice-pdf : build novice R PDF.
r-novice-pdf : _book/r-novice/r-novice.pdf

##   py-pdf : build novice Python PDF.
py-novice-pdf : _book/py-novice/py-novice.pdf

##   py-rse-pdf : build RSE PY PDF.
py-rse-pdf : _book/py-rse/py-rse.pdf

_book/r-novice/r-novice.pdf : ${R_NOVICE_FILES} ${COMMON_FILES}
	rm -f r-novice.Rmd
	cp r-novice-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::pdf_book', config_file='_r-novice.yml'); warnings()"

_book/py-novice/py-novice.pdf : ${PY_FILES} ${COMMON_FILES}
	rm -f py-novice.Rmd
	cp py-novice-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::pdf_book', config_file='_py-novice.yml'); warnings()"

_book/py-rse/py-rse.pdf : ${PY_RSE_FILES} ${COMMON_FILES}
	rm -f py-rse.Rmd
	cp py-rse-index.Rmd index.Rmd
	Rscript -e "options(bookdown.render.file_scope = FALSE); bookdown::render_book(input='index.Rmd', output_format='bookdown::pdf_book', config_file='_py-rse.yml'); warnings()"

#-------------------------------------------------------------------------------

## clean : clean up generated files.
clean :
	@rm -rf _book _bookdown_files _main.Rmd index.Rmd py-novice.Rmd r-novice.Rmd py-rse.Rmd r-rse.Rmd
	@rm -f *.aux *.lof *.log *.lot *.out *.toc
	@find . -name '*~' -exec rm {} \;

## chapters : check consistency of chapters.
chapters :
	@make settings | bin/chapters.py _py-rse.yml PY_RSE_FILES py-rse/objectives.Rmd py-rse/keypoints.Rmd

## crossrefs : check cross-references.
crossrefs :
	@bin/crossrefs.py "RSE PY" ${PY_RSE_FILES} ${COMMON_FILES}

## fixme : list all the FIXME markers
fixme :
	@fgrep FIXME ${PY_RSE_FILES} ${COMMON_FILES}

## glossary : rebuild the Markdown glossary file
glossary :
	echo '# Glossary {#glossary}' > glossary.md
	echo '' >> glossary.md
	${GLOSS}/utils/merge.py ${GLOSS}/glossary.yml ./glossary.yml \
	| bin/glossarize.py glossary-slugs.txt \
	>> glossary.md

## images : check that all images are defined and used.
images :
	@bin/images.py ./figures ${PY_RSE_FILES} ${COMMON_FILES}

## links : check that links and glossary entries are defined and used.
links :
	@bin/links.py ./links.md ./glossary.md ${PY_RSE_FILES} ${COMMON_FILES}

## exercises : check that exercises have solutions and solutions have exercises.
exercises :
	@bin/exercises.py ${PY_RSE_FILES}

## nbspref : check that all cross-references are prefixed with a non-breaking space.
nbspref :
	@bin/nbspref.py ${PY_RSE_FILES} ${COMMON_FILES}

## proposals : regenerate PDFs of proposals.
proposals :
	pandoc -o manning/manning-proposal-2020-07.pdf manning/manning-proposal-2020-07.md
	pandoc -o taylor-francis/taylor-francis-proposal-2020-07.pdf taylor-francis/taylor-francis-proposal-2020-07.md

## settings : echo all variable values.
settings :
	@echo ALL_HTML: ${ALL_HTML}
	@echo ALL_PDF: ${ALL_PDF}
	@echo R_NOVICE_FILES: ${R_NOVICE_FILES}
	@echo PY_NOVICE_FILES: ${PY_NOVICE_FILES}
	@echo PY_RSE_FILES: ${PY_RSE_FILES}
	@echo COMMON_FILES: ${COMMON_FILES}
	@echo ALL_FILES: ${ALL_FILES}

## tex-packages : install required LaTeX packages.
tex-packages :
	-tlmgr install $$(cat ./tex-packages.txt)
