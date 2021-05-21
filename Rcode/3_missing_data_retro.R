# 3_missing_data_retro.R
# run PlanBsmooth 10 year retro 
# compare all data to terminal year minus one missing data
# this situation faced by Georges Bank cod in 2021 management track

# set working directory to source file location to begin

library(PlanBsmooth)
library(dplyr)

dat <- read.csv("../data/ADIOS_ALL.csv") 

stocks <- as.vector(unique(dat$StockID))
nstocks <- length(stocks)

mynpeels <- 9 # so get 10 comparisons for each stock (includes peel=0)

df <- data.frame(StockID = character(),
                 TermYear = integer(),
                 peel = integer(),
                 full.data.mult = double(),
                 missing.data.mult = double())

for (istock in 1:nstocks){
  thisdat <- dat %>%
    filter(StockID == stocks[istock])
    
  orig <- thisdat %>%
    rowwise() %>%
    mutate(avg = mean(c(Spring, Fall_lag), na.rm = TRUE)) %>%
    select(Year, avg)

  orig.retro <- RunRetro(orig, npeels = mynpeels)

  maxyear <- max(orig$Year)
  
  year.peel <- data.frame(Year = seq(maxyear, (maxyear - mynpeels), -1),
                        peel = seq(0, mynpeels))
  base.mults <- left_join(year.peel, orig.retro$mult.ribbon)

# remove a year of data from end of series and run retro by hand
  miss.mults <- year.peel %>%
    mutate(miss.mult = NA)

  for (i in 1:(mynpeels + 1)){
    mypeel <- i - 1
    myYear <- maxyear - mypeel
    retro <- thisdat %>%
      filter(Year <= myYear) %>%
      mutate(Spring = ifelse(Year == myYear - 1, NA, Spring),
             Fall_lag = ifelse(Year == myYear, NA, Fall_lag))
    mymissing <- retro %>%
      rowwise() %>%
      mutate(avg = mean(c(Spring, Fall_lag), na.rm = TRUE)) %>%
      select(Year, avg)
    myres <- ApplyPlanBsmooth(mymissing, my.title=paste("Missing Retro Peel", mypeel))
    miss.mults$miss.mult[i] <- myres$multiplier
  }
  
  thisdf <- data.frame(StockID = stocks[istock],
                       TermYear = base.mults$Year,
                       peel = base.mults$peel,
                       full.data.mult = base.mults$mult,
                       missing.data.mult = miss.mults$miss.mult)
  
  df <- rbind(df, thisdf)
}

write.csv(df, file = "../data/multipliers.csv", row.names = FALSE)

