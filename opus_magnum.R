require(ggplot2)
require(dplyr)

## ##
d <- read.csv("opus_magnum.csv", sep = ';', dec = ",",  header=T, na.string="NA");

dm <- d %>% mutate(cat = factor(yyyy)) %>%
  group_by (cat) %>%
  summarise( tdist = sum(dist, na.rm=TRUE) /1000 ) %>%
  as.data.frame

dm

yyyy.first <- first(dm$cat)
yyyy.last <- last(dm$cat)

time.period <- sprintf ("%s--%s", yyyy.first, yyyy.last)

time.period


p.m <- ggplot(dm, aes(x = cat, y = tdist )) +
    ggtitle(sprintf ("Distance by year (%s)", time.period)) +
    xlab("year") + ylab("ths km") +
    geom_bar(position = 'dodge', stat = 'identity', fill = "steelblue") +
    geom_text(data=dm, aes(label=sprintf("%.2f", tdist), y= tdist), vjust=1.5, color="darkblue", size=3 )

p.m

ggsave(p.m, file="opus_magnum.pdf", width=12)
