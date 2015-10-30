#################################################
## data has been read and put into variable pf ##
#################################################

## By default ess data directory: (setq ess-directory "~/data/")
## To change the directory with ESS:
## ess-change-directory
setwd('~/workspace/udacity/explore-one-variable/data/')
## Create pasted URL
url <- paste("https://s3.amazonaws.com",
             "udacity-hosted-downloads",
             "ud651",
             "pseudo_facebook.tsv",
             sep = "/")

file.name <- "pseudo_facebook.tsv"

if(!file.exists(file.name))
    file.tsv <- download.file(url = url,
                            destfile = "pseudo_facebook.tsv",
                            method = 'libcurl') 

pf <- read.delim(file.name, sep="\t")
