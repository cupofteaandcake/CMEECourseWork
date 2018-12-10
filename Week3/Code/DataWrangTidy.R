#!/usr/bin/env Rscript

# illustrates wrangling csv data using Tidyr & Dplyr (Tidyverse packages)

# __appname__ = DataWrangTidy.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

################################################################
################## Wrangling the Pound Hill Dataset using dplyr ############
################################################################

############# Load the dataset ###############
require(dplyr)
require(tidyr)

# header = true because we do have metadata headers
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = F))

MyData <- t(MyData)
MyData[MyData == ""] = 0

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)
colnames(TempData) = MyData[1,]
rownames(TempData) = NULL

dplyr::tbl_df(TempData)
dplyr::glimpse(TempData)

MyWrangledData <- TempData %>% 
#  group_by(Species) %>% 
  gather(key = species,value = count, 5:45)

dplyr::glimpse(MyWrangledData)

MyWrangledData %>% 
  dplyr::mutate_at(vars(matches('Cultivation|Block|Plot|Quadrat')), funs(factor)) %>% 
                   mutate_at(vars(matches('count')), funs(as.numeric))

dplyr::glimpse(MyWrangledData)
