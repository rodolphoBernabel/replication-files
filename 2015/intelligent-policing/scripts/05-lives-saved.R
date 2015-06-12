##############################
# Calculation of Lives Saved #
##############################

# Clear the workspace
rm(list = ls())

# Load necessary packages
library(RCurl) # download dataset

# Download dataset from GitHub (SHA: b7b44bd5798787c2164a1a12019eb3dc1bb524ee)
github.url <- getURL("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/data/df.csv")
df <- read.csv(text = github.url, header = TRUE)

# Source 02-data-analysis.R from GitHub. 
source_https <- function(url, ...) {
        # load package
        require(RCurl)
        
        # parse and evaluate each .R script
        sapply(c(url, ...), function(u) {
                eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
        })
}

source_https("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/scripts/02-data-analysis.R")

# Weights below retrieved form dataprep.out
# State Code  State Weight  State Name        State Abbreviation
# 42          0.274         Santa Catarina    SC 
# 53          0.210         Distrito Federal  DF 
# 32          0.209         Espirito Santo    ES
# 33          0.169         Rio de Janeiro    RJ
# 14          0.137         Roraima    		  RR
# 14          0.001         Pernambuco   	  PB
# 35                        Sao Paulo         SP

# Get years after policy change
df.2 <- df[which( df$year >= 1999),]

# Calculate total number of deaths in SP
num.deaths.sp <- sum( (df.2$homicide.rates[which(df.2$abbreviation == "SP")])/100000 * (df.2$population.projection[which(df.2$abbreviation == "SP")]))

#Calculate estimated number of deaths in Synthetic São Paulo
num.deaths.synthetic.sp <- sum( (0.274 * (df.2$homicide.rates[which(df.2$abbreviation == "SC")])/100000 * (df.2$population.projection[which(df.2$abbreviation == "SP")]))
                                + (0.210 * (df.2$homicide.rates[which(df.2$abbreviation == "DF")])/100000 * (df.2$population.projection[which(df.2$abbreviation == "SP")]))
                                + (0.209 * (df.2$homicide.rates[which(df.2$abbreviation == "ES")])/100000 * (df.2$population.projection[which(df.2$abbreviation == "SP")]))
                                + (0.169 * (df.2$homicide.rates[which(df.2$abbreviation == "RJ")])/100000 * (df.2$population.projection[which(df.2$abbreviation == "SP")]))
                                + (0.137 * (df.2$homicide.rates[which(df.2$abbreviation == "RR")])/100000 * (df.2$population.projection[which(df.2$abbreviation == "SP")]))
                                + (0.001 * (df.2$homicide.rates[which(df.2$abbreviation == "PB")])/100000 * (df.2$population.projection[which(df.2$abbreviation == "SP")]))
                                )

lives.saved <- num.deaths.synthetic.sp - num.deaths.sp
lives.saved # Between 1999 and 2009

# sessionInfo()

# R version 3.2.0 (2015-04-16)
# Platform: x86_64-pc-linux-gnu (64-bit)
# Running under: Ubuntu 14.04.2 LTS

# locale:
#  [1] LC_CTYPE=en_GB.UTF-8       LC_NUMERIC=C              
#  [3] LC_TIME=en_GB.UTF-8        LC_COLLATE=en_GB.UTF-8    
#  [5] LC_MONETARY=en_GB.UTF-8    LC_MESSAGES=en_GB.UTF-8   
#  [7] LC_PAPER=en_GB.UTF-8       LC_NAME=C                 
#  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
# [11] LC_MEASUREMENT=en_GB.UTF-8 LC_IDENTIFICATION=C       

# attached base packages:
# [1] stats     graphics  grDevices utils     datasets  methods   base     

# other attached packages:
# [1] Synth_1.1-5    RCurl_1.95-4.6 bitops_1.0-6  

# loaded via a namespace (and not attached):
#  [1] Rvmmin_2013-11.12    minqa_1.2.4          Rcgmin_2013-2.21    
#  [4] optextras_2013-10.28 Rcpp_0.11.6          svUnit_0.7-12       
#  [7] ucminf_1.1-3         setRNG_2013.9-1      BB_2014.10-1        
# [10] dfoptim_2011.8-1     optimx_2013.8.7      numDeriv_2014.2-1   
# [13] kernlab_0.9-20       quadprog_1.5-5      