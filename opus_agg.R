require(ggplot2)
require(dplyr)

## ##
d <- read.csv("c2018.csv", sep = ';', dec = ",",  header=T, na.string="NA");
#d <- read.csv("c2019.csv", sep = ';', dec = ",",  header=T, na.string="NA");

rides = nrow (d)
total = sum (d$dist)
mride = mean (d$dist)
## ##
dm <- d %>% mutate(cat = factor(mm)) %>%
  group_by (cat) %>%
  summarise( ss = sum(dist, na.rm=TRUE)) %>%
  as.data.frame

p.m <- ggplot(dm, aes(x = cat, y = ss )) +
    ggtitle(sprintf ("Cycling in 2018 (total: %.1f kms/ %i rides/ %.1f kms per ride)", total, rides,  mride)) +
    xlab("month") + ylab("km") +
    geom_bar(position = 'dodge', stat = 'identity', fill = "steelblue", alpha=.5) +
    geom_text(data=dm, aes(label=sprintf("%.0f", ss), y= ss), vjust=1.5, color="white" )

p.m
