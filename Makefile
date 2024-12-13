# Makefile
# This Makefile replicates the functionality of the run_all.sh script
# It processes text files, creates plots, and renders a report.

# Variables
TEXTS = data/isles.txt data/abyss.txt data/last.txt data/sierra.txt
DATA = results/isles.dat results/abyss.dat results/last.dat results/sierra.dat
FIGURES = results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
REPORT = report/count_report.html

# Default rule
all: $(DATA) $(FIGURES) $(REPORT)

# Rule for generating data files
results/%.dat: data/%.txt
	python scripts/wordcount.py --input_file=$< --output_file=$@

# Rule for generating plots
results/figure/%.png: results/%.dat
	python scripts/plotcount.py --input_file=$< --output_file=$@

# Rule for rendering the report
$(REPORT): report/count_report.qmd $(FIGURES)
	quarto render $<

# Clean up generated files
clean:
	rm -f $(DATA) $(FIGURES) $(REPORT)
