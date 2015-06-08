######################
### Data Wrangling ###
######################

# Clear the workspace
rm(list = ls())

# Load necessary packages
library(RCurl)     # download data files
library(reshape2)  # data manipulation

# Download csv files. SHA: b7b44bd5798787c2164a1a12019eb3dc1bb524ee
# Dependent variables:
dep.url <- getURL("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/data/homicide-rates.csv")
dep <- read.csv(text = dep.url,
                header = TRUE,
                skip   = 1)

dep.molten <- melt(dep,
                   id.vars = c("Sigla",
                               "Código",
                               "Estado")
                    )

colnames(dep.molten) <- c("abbreviation",
                          "code",
                          "state",
                          "year",
                          "homicide.rates")

dep.molten$year <- as.numeric(substring(dep.molten$year, 2))

# Independent variables
ind1.url <- getURL("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/data/state-gdp-capita.csv")
ind1 <- read.csv(text = ind1.url,
                 header = TRUE,
                 skip   = 1)

ind1.molten <- melt(ind1,
                    id.vars = c("Sigla",
                                "Código",
                                "Estado")
                    )

colnames(ind1.molten) <- c("abbreviation",
                           "code",
                           "state",
                           "year",
                           "state.gdp.capita")

ind1.molten$year <- as.numeric(substring(ind1.molten$year, 2))

ind2.url <- getURL("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/data/state-gdp-growth-percentage.csv")
ind2 <- read.csv(text = ind2.url,
                 header = TRUE,
                 skip   = 1)

ind2.molten <- melt(ind2,
                    id.vars = c("Sigla",
                                "Código",
                                "Estado")
                    )

colnames(ind2.molten) <- c("abbreviation",
                           "code",
                           "state",
                           "year",
                           "state.gdp.growth.percent")

ind2.molten$year <- as.numeric(substring(ind2.molten$year, 2))

ind3.url <- getURL("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/data/gini.csv")
ind3 <- read.csv(text = ind3.url,
                 header = TRUE,
                 skip   = 1)

ind3.molten <- melt(ind3,
                    id.vars = c("Sigla",
                                "Código",
                                "Estado")
                    )

colnames(ind3.molten) <- c("abbreviation",
                           "code",
                           "state",
                           "year",
                           "gini")

ind3.molten$year <- as.numeric(substring(ind3.molten$year, 2))

ind4.url <- getURL("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/data/population-projection.csv")
ind4 <- read.csv(text = ind4.url,
                 header = TRUE,
                 skip   = 1)

ind4.molten <- melt(ind4,
                    id.vars = c("Sigla",
                                "Código",
                                "Estado")
                    )

colnames(ind4.molten) <- c("abbreviation",
                           "code",
                           "state",
                           "year",
                           "population.projection")

ind4.molten$year <- as.numeric(substring(ind4.molten$year, 2))

ind5.url <- getURL("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/data/population-extreme-poverty.csv")
ind5 <- read.csv(text = ind5.url,
                 header = TRUE,
                 skip   = 1)

ind5.molten <- melt(ind5,
                    id.vars = c("Sigla",
                                "Código",
                                "Estado")
                    )

colnames(ind5.molten) <- c("abbreviation",
                           "code",
                           "state",
                           "year",
                           "population.extreme.poverty")

ind5.molten$year <- as.numeric(substring(ind5.molten$year, 2))

ind6.url <- getURL("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/data/years-schooling.csv")
ind6 <- read.csv(text = ind6.url,
                 header = TRUE,
                 skip   = 1)

ind6.molten <- melt(ind6,
                    id.vars = c("Sigla",
                                "Código",
                                "Estado")
                    )

colnames(ind6.molten) <- c("abbreviation",
                           "code",
                           "state",
                           "year",
                           "years.schooling")

ind6.molten$year <- as.numeric(substring(ind6.molten$year, 2))

# Merges files
data.list <- list(dep.molten,
                  ind1.molten,
                  ind2.molten,
                  ind3.molten,
                  ind4.molten,
                  ind5.molten,
                  ind6.molten)

data1 <- Reduce(function(...) merge(..., all = TRUE), data.list)
               
# Subset and sort
data2 <- subset(data1, year >= 1990 & year <= 2009)
data2 <- data2[order(data2$state), ]
rownames(data2) <- NULL

# Count missing observations, calculate their percentage
round(sapply(data2, function(x) length(which(is.na(x)))), 2)      
round(sapply(data2, function(x) length(which(is.na(x)))/length(x)), 2)

# Linear imputation of missing values.
data2$gini.imp <- approxfun(seq_along(data2$gini), data2$gini)(seq_along(data2$gini))
data2$population.extreme.poverty.imp <- approxfun(seq_along(data2$population.extreme.poverty), data2$population.extreme.poverty)(seq_along(data2$population.extreme.poverty))
data2$years.schooling.imp <- approxfun(seq_along(data2$years.schooling), data2$years.schooling)(seq_along(data2$years.schooling))

# Create proportion.extreme.poverty
data2$proportion.extreme.poverty <- data2$population.extreme.poverty.imp / data2$population.projection

# Transform variables to improve interpretation
data2$population.projection.ln <- log(data2$population.projection)

# Save data as df.csv
write.table(data2,
            "/home/sussa/Desktop/df.csv",
            row.names = FALSE,
            col.names = TRUE,
            sep       = ",")

# sessionInfo()

# R version 3.2.0 (2015-04-16)
# Platform: x86_64-pc-linux-gnu (64-bit)
# Running under: Ubuntu 14.04.2 LTS

# locale:
# [1] LC_CTYPE=en_GB.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB.UTF-8       
# [4] LC_COLLATE=en_GB.UTF-8     LC_MONETARY=en_GB.UTF-8    LC_MESSAGES=en_GB.UTF-8   
# [7] LC_PAPER=en_GB.UTF-8       LC_NAME=C                  LC_ADDRESS=C              
# [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_GB.UTF-8 LC_IDENTIFICATION=C       

# attached base packages:
# [1] stats     graphics  grDevices utils     datasets  methods   base     

# other attached packages:
# [1] reshape2_1.4.1 RCurl_1.95-4.6 bitops_1.0-6 

# loaded via a namespace (and not attached):
# [1] BB_2014.10-1         Rcpp_0.11.6          quadprog_1.5-5       optextras_2013-10.28
# [5] ucminf_1.1-3         plyr_1.8.2           magrittr_1.5         stringi_0.4-1       
# [9] setRNG_2013.9-1      minqa_1.2.4          kernlab_0.9-20       optimx_2013.8.7     
# [13] tools_3.2.0          svUnit_0.7-12        stringr_1.0.0        Rvmmin_2013-11.12   
# [17] numDeriv_2014.2-1    dfoptim_2011.8-1     Rcgmin_2013-2.21    
