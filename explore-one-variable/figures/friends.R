setwd('~/workspace/udacity/explore-one-variable/figures/')
source('../data/data.R')                        # Data file set directory
source('../lib.R')

tikz('friends.tex',
     standAlone = T,
     sanitize = T,
     width = 5,
     height = 5)

###########################################################
## qplot(data = subset(x = pf, subset = !is.na(gender)), ##
##       x = friend_count,                               ##
##       binwidth = 25) +                                ##
##     scale_x_continuous(limits = c(0, 1000),           ##
##                        breaks = seq(0,1000,100)) +    ##
##     facet_wrap(~gender, ncol = 1) +                   ##
##     stat_summary(fun.x = "median", geom = "point") +  ##
##     theme_bw()                                        ##
###########################################################

med <- median(x = pf$friend_count,
              na.rm = T)
av <- mean(x = pf$friend_count)
ggplot(data = pf,
       aes(x = friend_count)) +
    geom_histogram() +
    stat_bin(binwidth = 25) +
    scale_x_continuous(limits = c(0, 1000),
                       breaks = seq(0, 1000, 100)) +
    geom_vline(xintercept = med,
               colour = "red") +
    geom_vline(xintercept = av,
               colour = "blue") +
    theme_hc()

dev.off()

tools::texi2dvi(file = 'friends.tex',
                clean = T,
                pdf = T)
