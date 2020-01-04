d <- read.csv("2017_dist.csv", sep = ';',  header=T, na.string="NA");

str(d)

pdf(file="2017_dist.pdf", onefile = TRUE);

hist(d$dist, breaks=seq(0, 250, by=10),
       freq=TRUE,col="orange",main="Rides by distance 2017",
       xlab="kms",ylab="#N",yaxs="i",xaxs="i")

dev.off()
