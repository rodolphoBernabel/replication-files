##############
### Graphs ###
##############

# Clear the workspace
rm(list = ls())

# Source 03-robustness-test.R from GitHub.
source_https <- function(url, ...) {
        # load package
        require(RCurl)
        
        # parse and evaluate each .R script
        sapply(c(url, ...), function(u) {
                eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
        })
}

source_https("https://raw.githubusercontent.com/danilofreire/replication-files/master/2015/intelligent-policing/scripts/03-robustness-tests.R")

# Plot -- Main model
setEPS()
postscript(file    = "trends.eps",
           horiz   = FALSE, 
           onefile = FALSE, 
           width   = 7,     # 17.8 cm
           height  = 5.25)  # 13.3 cm

path.plot(synth.res    = synth.out,
          dataprep.res = dataprep.out,
          Ylab         = c("Homicide Rates"),
          Xlab         = c("Year"), 
          Legend       = c("São Paulo","Synthetic São Paulo")
          ) 

abline(v   = 1999,
       lty = 2)

arrows(1997, 50, 1999, 50, 
       col    = "black",
       length = .1)

text(1995, 50,
     "Policy Change",
     cex = .8)

invisible(dev.off())

# Main model: gaps plot
setEPS()
postscript(file    = "gaps.eps",
           horiz   = FALSE, 
           onefile = FALSE, 
           width   = 7,    
           height  = 5.25) 

gaps.plot(synth.res    = synth.out,
          dataprep.res = dataprep.out, 
          Ylab         = c("Homicide Rates"),
          Xlab         = c("Year"), 
          Ylim         = c(-30, 30),
          Main         = ""
          )

abline(v   = 1999,
       lty = 2)

invisible(dev.off())

# Placebo test
setEPS()
postscript(file    = "placebo.eps",
           horiz   = FALSE, 
           onefile = FALSE, 
           width   = 7,     
           height  = 5.25) 

path.plot(synth.res       = synth.out1,
          dataprep.res    = dataprep.out1,
          Ylab            = c("Homicide Rates"),
          Xlab            = c("Year"), 
          Legend          = c("São Paulo","Synthetic São Paulo"),
          Legend.position = c("bottom"),
          Ylim            = c(0, 50)
          ) 

abline(v   = 1995,
       lty = 2)

arrows(1994, 40, 1995, 40, 
       col    = "black",
       length = .1)

text(1992, 40,
     "Placebo \nPolicy Change",
     cex = .8)

invisible(dev.off())

# Placebo test: gaps plot
setEPS()
postscript(file    = "gaps-placebo.eps",
           horiz   = FALSE, 
           onefile = FALSE, 
           width   = 7,   
           height  = 5.25)  

gaps.plot(synth.res    = synth.out1,
          dataprep.res = dataprep.out1, 
          Ylab         = c("Homicide Rates"),
          Xlab         = c("Year"), 
          Ylim         = c(-30, 30),
          Main         = ""
          )

abline(v   = 1995,
       lty = 2)

invisible(dev.off())

# Leave-one-out
setEPS()
postscript(file    = "leave-one-out.eps",
           horiz   = FALSE, 
           onefile = FALSE, 
           width   = 7,   
           height  = 5.25) 

plot(1990:2009,
     dataprep.out2$Y1plot,
     type = "l",
     ylim = c(0, 60),
     col  = "black",
     lty  = "solid",
     ylab = "Homicide Rates",
     xlab = "Year",
     xaxs = "i",
     yaxs = "i",
     lwd  = 2
     )

abline(v   = 1999,
       lty = "dotted")

arrows(1997, 50, 1999, 50, 
       col    = "black",
       length = .1)

for(i in 1:4){
        lines(1990:2009,
              storegaps[,i],
              col = "darkgrey",
              lty = "solid")
}

lines(1990:2009,
      dataprep.out$Y0plot %*% synth.out$solution.w,
      col = "black",
      lty = "dashed",
      lwd = 2)

lines(1990:2009,
      dataprep.out$Y1plot,
      col = "black",
      lty = "solid",
      lwd = 2)

text(1995, 50,
     "Policy Change",
     cex = .8)

legend(x = "bottomleft",
       legend = c("São Paulo",
                  "Synthetic São Paulo",
                  "Synthetic São Paulo (leave-one-out)"
                  ),
       lty    = c("solid", "dashed", "solid"),
       col    = c("black", "black", "darkgrey"),
       cex    = .8,
       bg     = "white",
       lwdc(2, 2, 1)
       )

invisible(dev.off())

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