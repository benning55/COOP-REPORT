@ECHO OFF 
:: This batch file run to create report with 
TITLE My System Info
ECHO Please wait... Checking system information.
makeindex full-report.tex
miktex-xelatex full-report.tex
bibtex full-report
miktex-xelatex full-report.tex
miktex-xelatex full-report.tex
ECHO Finish Create Doc!