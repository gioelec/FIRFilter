SET main=main
@echo off
cls
echo PDFLATEX --- 1/2
pdflatex  -aux-directory out/ %main%.tex   
echo PDFLATEX --- 2/2
pdflatex  -aux-directory out/ -quiet %main%.tex
echo DONE --- OPENING PDF 1/1
START "" %main%.pdf