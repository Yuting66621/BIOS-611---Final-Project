R = Rscript
.PHONY: all clean

all: report.html

report.html: report.Rmd data/hcvdat0.csv
	$(R) -e "rmarkdown::render('report.Rmd', output_file = 'report.html')"

# Clean
clean:
	rm -f report.html
	rm -rf figures/*.png