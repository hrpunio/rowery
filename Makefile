all:
	##$(MAKE) -f Makefile.gnu
	##$(MAKE) -f Makefile.andromeda
	$(MAKE) -f Makefile.neptune 

dist:
	##$(MAKE) -f Makefile.gnu dist
	##$(MAKE) -f Makefile.andromeda dist
	$(MAKE) -f Makefile.neptune dist

hist:
	R CMD BATCH 2017_dist.R
	convert -flatten -density 300 2017_dist.pdf 2017_dist.png
xdist:
	R CMD BATCH dist_boxplot.R &&  convert Rplots.pdf dist_1993-2017.png
	convert -flatten -density 300 Rplots.pdf dist_1993-2017F.png 
