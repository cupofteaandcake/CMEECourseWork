################################################################
################## Wrangling the Pound Hill Dataset using dplyr ############
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = F)) 

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

rownames(TempData) <- NULL
head(TempData)

############# Convert from wide to long format  ###############
require(dplyr)
require(tidyr)

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