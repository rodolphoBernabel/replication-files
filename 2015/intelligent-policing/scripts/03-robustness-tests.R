########################
### Robustness Tests ###
########################


# Clear the workspace
rm(list = ls())

# Source data-analysis.R from GitHub. 
source_https <- function(url, ...) {
        # load package
        require(RCurl)
        
        # parse and evaluate each .R script
        sapply(c(url, ...), function(u) {
                eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
        })
}

source_https("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/scripts/02-data-analysis.R")

## Placebo Test 1 -- Control ends in 1994
dataprep.out1 <-
        dataprep(df,
                 predictors = c("state.gdp.capita",
                                "state.gdp.growth.percent",
                                "population.projection.ln",
                                "years.schooling.imp"
                 ),
                 special.predictors = list(
                         list("homicide.rates", 1990:1994, "mean"),
                         list("proportion.extreme.poverty", 1990:1994, "mean"),
                         list("gini.imp", 1990:1994, "mean")
                 ),
                 predictors.op = "mean",
                 dependent     = "homicide.rates",
                 unit.variable = "code",
                 time.variable = "year",
                 unit.names.variable   = "state",
                 treatment.identifier  = 35,
                 controls.identifier   = c(11:17, 21:27, 31:33, 41:43, 50:53),
                 time.predictors.prior = c(1990:1994),                 
                 time.optimize.ssr     = c(1990:1994),
                 time.plot             = c(1990:1998)
                 )

# Run synth
synth.out1 <- synth(dataprep.out1)

# Get result tables
print(synth.tables   <- synth.tab(
        dataprep.res = dataprep.out1,
        synth.res    = synth.out1)
      )

# Leave-one-out

# Loop over leave one outs
storegaps <- matrix(NA,
                    length(1990:2009),
                    4)

colnames(storegaps) <- c(14, 33, 42, 53) # RR, RJ, SC, DF
co <- unique(df$code) 
co <- co[-25]

for(k in 1:4){
        
        # Data prep for training model
        omit <- c(14, 33, 42, 53)[k]  
        
        # Prepare data for synth
        dataprep.out2 <-
                dataprep(df,
                         predictors = c("state.gdp.capita",
                                        "state.gdp.growth.percent",
                                        "population.projection.ln",
                                        "years.schooling.imp"
                         ),
                         special.predictors = list(
                                 list("homicide.rates", 1990:1998, "mean"),
                                 list("proportion.extreme.poverty", 1990:1998, "mean"),
                                 list("gini.imp", 1990:1998, "mean")
                         ),
                         predictors.op = "mean",
                         dependent     = "homicide.rates",
                         unit.variable = "code",
                         time.variable = "year",
                         unit.names.variable   = "state",
                         treatment.identifier  = 35,
                         controls.identifier   = co[-which(co==omit)],
                         time.predictors.prior = c(1990:1998),                 
                         time.optimize.ssr     = c(1990:1998),
                         time.plot             = c(1990:2009)
                )
   
        # Run synth
        synth.out2 <- synth(dataprep.out2)
        
        storegaps[,k] <- (dataprep.out2$Y0%*%synth.out2$solution.w)
} # Close loop over leave one outs

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
# [1] Synth_1.1-5    reshape2_1.4.1 RCurl_1.95-4.6 bitops_1.0-6  

# loaded via a namespace (and not attached):
# [1] BB_2014.10-1         Rcpp_0.11.6          quadprog_1.5-5       optextras_2013-10.28
# [5] ucminf_1.1-3         plyr_1.8.2           magrittr_1.5         stringi_0.4-1       
# [9] setRNG_2013.9-1      minqa_1.2.4          kernlab_0.9-20       optimx_2013.8.7     
# [13] tools_3.2.0          svUnit_0.7-12        stringr_1.0.0        Rvmmin_2013-11.12   
# [17] numDeriv_2014.2-1    dfoptim_2011.8-1     Rcgmin_2013-2.21    