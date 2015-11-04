library(datasets)
library(ggplot2)
library(ggthemes)
library(gridExtra)
str(mtcars)

## little histogram to explore some data
p0 <- ggplot(aes(x = hp),                     # hp = Horse Power
             data = mtcars) +
    theme_hc() +
    ggtitle("Horse power density from sample") +
    xlab("Horse power") +
    ylab("sample")

p1 <- p0 +
    geom_histogram(binwidth = 20,
                   color = '#333333',
                   fill = 'darkgreen') +
    scale_x_continuous(limits = c(50, 340),
                       breaks = seq(50, 350, 50))

p2 <- p0 +
    geom_histogram()
    scale_x_log10()


grid.arrange(p1, p2, ncol = 2)

summary(mtcars$hp)

   ###################################################
   ## Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  ##
   ## 52.0    96.5   123.0   146.7   180.0   335.0  ##
   ###################################################
sum(mtcars$hp <= 96.5) / length(mtcars$hp) # Equal 25% ... awful!
sum(mtcars$hp <= 123.0) / length(mtcars$hp) # Equal 53% ... midpoint.
sum(mtcars$hp <= 180) / length(mtcars$hp) # Equal 78% ... about 75%...

hp_quantile <- quantile(mtcars$hp,
         probs = seq(0, 1, 0.25),
         na.rm = T,
         names = T)
hp_quantile[1] == hp_quantile['0%']     # TRUE, obviously...
## quantile without name:

unname(hp_quantile['25%'])              # [1] 96.5
hp_quantile[2]                          # return: 
##  25% 
## 96.5

#############################################################################
## ## IQR                                                                  ##
##                                                                         ##
## Usage:                                                                  ##
##                                                                         ##
##      IQR(x, na.rm = FALSE, type = 7)                                    ##
##                                                                         ##
## Arguments:                                                              ##
##                                                                         ##
##        x: a numeric vector.                                             ##
##                                                                         ##
##    na.rm: logical. Should missing values be removed?                    ##
##                                                                         ##
##     type: an integer selecting one of the many quantile algorithms, see ##
##           'quantile'.                                                   ##
#############################################################################
## following two rows give same solution
IQR(x = mtcars$hp)
unname(hp_quantile['75%']) - unname(hp_quantile['25%'])
    
