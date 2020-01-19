require(ggplot2)
require(dplyr)


dist.25 <- 250000
dist.2019 <- 242355

###
today <- Sys.Date()
##tt<- format(today, "%d/%b/%Y")
tt<- format(today, "%Y")
##

ax.ticks <- as.factor(c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"))

d <- read.csv("opus_yr.csv", sep = ';', dec = ",",  header=F, na.string="NA");
names(d) <- c("dd", "mm", "yyyy", "dist")

dist.yr <- sum(d$dist)
pt <- dist.2019 + dist.yr

dm <- d %>% mutate(cat = factor(mm)) %>%
  group_by (cat) %>%
  summarise( tdist = sum(dist, na.rm=TRUE) ) %>%
  as.data.frame

str(dm)

###
yyyy.first <- first(dm$cat)
yyyy.last <- last(dm$cat)

time.period <- sprintf ("months: %s--%s", yyyy.first, yyyy.last)

time.period

p.m <- ggplot(dm, aes(x = cat, y = tdist )) +
    ggtitle(sprintf ("Personal cycling stats: distance covered in %s (%s)", tt, time.period),
          subtitle=sprintf("Personal total: %i kms", pt)) +
    xlab("month") + ylab("ths km") +
    geom_bar(position = 'dodge', stat = 'identity', fill = "steelblue") +
    scale_x_discrete(breaks=ax.ticks,  labels=c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")) +
    xlim("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12") +
    geom_text(data=dm, aes(label=sprintf("%.2f", tdist), y= tdist), vjust=1.5, color="darkblue", size=3 )

p.m

ggsave(p.m, file="opus_yr.png", width=9)
