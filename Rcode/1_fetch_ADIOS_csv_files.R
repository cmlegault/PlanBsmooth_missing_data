# 1_fetch_ADIOS_csv_files.R

# collects all csv files for survey stratfied mean values from ADIOS and copies them to local directory

# need to have connection to unix directory open for this work

# NOTE: this can take a while due to the large number of files in the ADIOS directory

# set working directory to source file location to begin

# unix dir
adios.dir <- "\\\\net.nefsc.noaa.gov\\home0\\pdy\\pub\\STOCKEFF\\ADIOS\\ADIOS_SV\\website\\webfiles"

# local dir
local.dir <- "../data"

# figure out which files to copy
list.of.files <- list.files(adios.dir, pattern = glob2rx("ADIOS_SV_*_strat_mean.csv"), full.names = TRUE)

# check to make sure correct files grabbed
list.of.files

# copy files
file.copy(from = list.of.files, to = local.dir, overwrite = TRUE)
