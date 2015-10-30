setwd('~/workspace/udacity/explore-one-variable/figures/')
source('../data/data.R')                        # Data file set directory
source('../lib.R')

tikz('friends.tex',
     standAlone = T,
     sanitize = T,
     width = 5,
     height = 5)

qplot(data = subset(x = pf, subset = !is.na(gender)),
      x = friend_count,
      binwidth = 25) +
    scale_x_continuous(limits = c(0, 1000),
                       breaks = seq(0,1000,100)) +
    facet_wrap(~gender, ncol = 1) +
    theme_bw()

dev.off()

tools::texi2dvi(file = 'friends.tex',
                clean = T,
                pdf = T)
