#!/usr/bin/env Rscript

#produces map with GPDD data plotted on it

# __appname__ = maps.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

require(maps)

load('../Data/GPDDFiltered.RData')

pdf('../Results/GPDDmap.pdf')
GPDDMap <- map(database = 'world', fill = TRUE, col = c('lightcyan', 'rosybrown1'))
points(gpdd$long, gpdd$lat, pch = 19, col = 'indianred1', cex=0.4)
graphics.off()

#The vast majority of the points included in the GPDD data are
#located in North America and Europe, with only one point in
#South Africa and one in Japan, which clearly indicates that
#the majority of the investment into collecting data has been
#in areas of great wealth, thereby indicating an increased lack
#of knowledge in less highly developed countries, which are often
#the areas with the greatest abundance of species