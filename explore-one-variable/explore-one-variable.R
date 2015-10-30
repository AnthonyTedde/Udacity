setwd('~/workspace/udacity/explore-one-variable/')
source('lib.R')
source('data.R')

## Give the columns names
names(pf)

## ggplot date of bird
## qplot means Quick plot
## Only plot  number of people according to the year of birth
qplot(data = pf,
      x = dob_year)

qplot(data = pf,
      x = dob_day) +
    scale_x_discrete(breaks = 1:31)


## Other way to produce the same plot such as previous one:
ggplot(data = pf,
       aes(x = dob_day)) +
    geom_histogram() +
        scale_x_discrete(breaks = 1:31)


qplot(data = pf,
      x = dob_day) +
    scale_x_discrete(breaks = 1:31) +
        facet_wrap(~dob_month, ncol = 3)

## histogram of friend count
## with only the first thousand of x axis data
## 3 differents way to accomplish
qplot(data = pf,
      x = friend_count,
      xlim = c(0,1000)) 

qplot(data = pf,
      x = friend_count) +
    scale_x_continuous(limits = c(0,1000))

ggplot(aes(x = friend_count), data = pf) +
    geom_histogram() +
        scale_x_continuous(limits = c(0,1000))

## adjust bin width
## Break the information displayed on x axis with breaks parameter:
## -> breaks = seq(0,1000, 50) means:
##      * From 0 to 1000
##      * Break measure on x axis each 50 steps.
qplot(data = pf,
      x = friend_count,
      binwidth = 25) +
    scale_x_continuous(limits = c(0,1000),
                       breaks = seq(0, 1000, 50))
## Break the previous histogram into two group: Male and female:
qplot(data = pf,
      x = friend_count,
      binwidth = 25) +
    scale_x_continuous(limits = c(0,1000),
                       breaks = seq(0,1000,50)) +
        facet_wrap(~gender, ncol = 1)

## previous graph generate a histogram for NA values
## The next one will remove the NA histogram by subsetting the data
qplot(data = subset(x = pf, subset = !is.na(gender)),
      x = friend_count,
      binwidth = 25) +
    scale_x_continuous(limits = c(0, 1000),
                       breaks = seq(0,1000,50)) +
        facet_wrap(~gender, ncol = 1)
## Can use instead sunset, the omit function
## this function omit all value inside dataset which has NA value
## Not only gender value
qplot(data = na.omit(pf),
      x = friend_count,
      binwidth = 25) +
    scale_x_continuous(limits = c(0,1000),
                       breaks = seq(0,1000,50)) +
        facet_wrap(~gender, ncol = 1)

## Return a one dimensional table with number of individual break into two groups
## based on gender: Male or Female
table(pf$gender)
## Return a two dimensional table with number of individual break into
## gender by age
table(pf$gender, pf$age)
## by: apply a function to a dataframe(or vector in the next case)
## split by factors variables            
by(data = pf$friend_count,
   INDICES = pf$gender,
   FUN = summary)
## To answer the question:
## Which gender on average has more friends?
by(data = pf$friend_count,
   INDICES = pf$gender,
   FUN = mean)
## Difference between median friends count for women and men
by(data = pf$friend_count,
   INDICES = pf$gender,
   FUN = median)

## sad way to find difference between two median:
median.friend.male <- median(x = pf[pf$gender == 'male', 'friend_count'],
       na.rm = T)
median.friend.female <- median(x = pf[pf$gender == 'female', 'friend_count'],
       na.rm = T)
abs(x = median.friend.female - median.friend.male)

## Happier way :)
median.friend.by_gender <- by(data = pf$friend_count,
   INDICES = pf$gender,
   FUN = median)
male <- unname(median.friend.by_gender["male"])
female <- unname(median.friend.by_gender["female"])
abs(x = male - female)
