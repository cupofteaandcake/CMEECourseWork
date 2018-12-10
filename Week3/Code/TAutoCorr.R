#!/usr/bin/env Rscript

#produces graph & p-value for correlation between temperatures independent of year

# __appname__ = TAutoCorr.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

load('../Data/KeyWestAnnualMeanTemperature.RData')
head(ats); tail(ats)
str(ats)
dim(ats)
pdf("../Results/KeyWestScatter.pdf")
plot(ats, pch=20)
abline(lm(ats$Temp~ats$Year), col = 'red')
graphics.off()

temp_t0 = ats[1:99, 2]
temp_t1 = ats[2:100, 2]

TempCor <- cor(temp_t0, temp_t1)

Cor <- numeric(length = 10000)
for (i in 1:10000) {
  temps_0 <- sample(temp_t0, replace = TRUE)
  temps_1 <- sample(temp_t1, replace = TRUE)
  Cor[i] <- cor(temps_0, temps_1)
}

# Cor <- numeric(length = 10000)
# doit <- function(x){
#   temps_0 <- sample(temp_t0, replace = TRUE)
#   temps_1 <- sample(temp_t1, replace = TRUE)
#   Cor[x] <- cor(temps_0, temps_1)
# }
# 
# result <- lapply(1:10000, function(x) doit(x))

pdf("../Results/TAutoCorr_histogram.pdf")
hist(Cor, col = 'lightsteelblue1')
abline(v = TempCor, col = 'firebrick1')
graphics.off()

p_value = length(Cor[Cor > TempCor])/length(Cor)
p_value