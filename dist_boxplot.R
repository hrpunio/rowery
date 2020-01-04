library (ggplot2);
#
d <- read.csv("1993_2017_dist.csv", sep = ';',  header=T, na.string="NA");
#d$year <- as.factor(d$year)
d$year <- factor(x = d$year, 
                          levels = c(1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017),
     labels =c("93","94","95","96","97","98","99","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17") )

str(d);
d

aggregate (d$dist, list(TripId = d$year), fivenum)

b <- ggplot (d, aes(x=year, y=dist)) + geom_boxplot()

#d, xlab = "Id", ylab = "Dist", col = "yellow")


#attributes(b)
#
#b$stats
#
#b
#
#m <- aggregate(d$dist, list(d$year), mean)
#
#attributes(m)
#
#md <- m$x
#
#length(md)

#md

#qplot(x, md)
