require(maps)

load('../Data/GPDDFiltered.RData')

GPDDMap <- map(database = 'world')
points(gpdd$long, gpdd$lat, pch = 19, col = 'indianred1', cex=0.5)

#The vast majority of the points included in the GPDD data are
#located in North America and Europe, with only one point in
#South Africa and one in Japan, which clearly indicates that
#the majority of the investment into collecting data has been
#in areas of great wealth, thereby indicating an increased lack
#of knowledge in less highly developed countries, which are often
#the areas with the greatest abundance of species