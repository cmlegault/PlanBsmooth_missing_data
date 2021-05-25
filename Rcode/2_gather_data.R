# 2_gather_data.R
# get stock-specific NEFSC spring and fall survey data from ADIOS files
# creates file ADIOS_ALL.csv 

# set working directory to source file location to begin

library(dplyr)
library(tidyr)

# local dir
local.dir <- "../data"

# figure out which files are present
list.of.files <- list.files(local.dir, pattern = glob2rx("ADIOS_SV_*_strat_mean.csv"))
nfiles <- length(list.of.files)

# create master file of stocks with both the NEFSC spring and fall surveys only
df <- data.frame(StockID = character(),
                 Year = integer(),
                 Spring = double(),
                 Fall_lag = double())

corrdf <- data.frame(StockID = character(),
                     corr = double())

istock <- 0
for (i in 1:nfiles){
  dat <- read.csv(file.path(local.dir, list.of.files[i]))
  
  # convert adios.dat to format that could be read by ReadRaw 
  adios.r <- dat %>%
    filter(INDEX_TYPE == "Biomass (kg/tow)",
           PURPOSE_CODE == 10) %>%   
    mutate(Year = ifelse(SEASON=="FALL",YEAR+1,YEAR)) %>%
    select(Year, SEASON, INDEX) %>%               
    pivot_wider(names_from = SEASON, values_from = INDEX, values_fill = NA) %>%
    filter(Year <= 2019)
  
  # make sure both SPRING and FALL present and first year before 1980
  if(dim(adios.r)[2] == 3){ 
    if (colnames(adios.r)[2] == "FALL" & 
        colnames(adios.r)[3] == "SPRING" & 
        adios.r$Year[1] <= 1980){ 
      
      if (dat$SPECIES_ITIS[1] == 164712 & dat$STOCK_ABBREV[1] == "GBK"){
        mystockID = "GBcod"
      } else {
        istock <- istock + 1
        mystockID = paste0("Stock", istock)
      }
      thisdf <- data.frame(StockID = mystockID,
                           Year = adios.r$Year,
                           Spring = adios.r$SPRING,
                           Fall_lag = adios.r$FALL)
      df <- rbind(df, thisdf)
      
      thiscorrdf <- data.frame(StockID = mystockID,
                               corr = cor(adios.r$SPRING, adios.r$FALL, use = "complete.obs"))
      corrdf <- rbind(corrdf, thiscorrdf)
    }
  }
}
df
unique(df$StockID)
corrdf

# save results
write.csv(df, file = file.path(local.dir, "ADIOS_ALL.csv"), row.names = FALSE)
write.csv(corrdf, file = file.path(local.dir, "correlations.csv"), row.names = FALSE)
