SET main=main
@echo off
color 3e
cls
echo PDFLATEX --- 1/2
color 2f
pdflatex  -aux-directory out/ -output-directory out/ %main%.tex   
echo PDFLATEX --- 2/2
color 1d
pdflatex  -aux-directory out/ -output-directory out/ -quiet %main%.tex
color
echo DONE --- OPENING PDF 1/1
color
pause
START "" out/%main%.pdf
