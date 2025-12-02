R = Rscript
.PHONY: all clean

all: report.html

report.html: report.Rmd data/hcvdat0.csv
	$(R) -e "rmarkdown::render('report.Rmd', output_format = 'html_document')"


# Clean
clean:
	rm -f report.html 
	rm -rf figures/*.png