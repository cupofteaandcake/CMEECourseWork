d <- read.table('../Data/SparrowSize.txt', header = TRUE)

str(d)
names(d)
head(d)

length(d$Tarsus)
hist(d$Tarsus)
mean(d$Tarsus)
mean(d$Tarsus, na.rm = TRUE)
median(d$Tarsus, na.rm = TRUE)
mode(d$Tarsus, na.rm = TRUE)
mode(d$Tarsus)

par(mfrow = c(2,2))
hist(d$Tarsus, breaks = 3, col='indianred1')
hist(d$Tarsus, breaks = 10, col = 'indianred1')
hist(d$Tarsus, breaks = 30, col = 'indianred1')
hist(d$Tarsus, breaks = 100, col = 'indianred1')

require(modeest)
mlv(d$Tarsus)

d2 <- subset(d, d$Tarsus!='NA')
length(d2$Tarsus)
mlv(d2$Tarsus)
#Mode (most likely value): 18.57361 
#Bickel's modal skewness: 0.0005934718 

mean(d2$Tarsus)
median(d2$Tarsus)
range(d2$Tarsus)

var(d2$Tarsus)
sum((d2$Tarsus - mean(d2$Tarsus))^2)/(length(d2$Tarsus) - 1)
sqrt(var(d2$Tarsus))
sqrt(0.74)
sd(d2$Tarsus)

zTarsus <- (d2$Tarsus - mean(d2$Tarsus))/sd(d2$Tarsus)
var(zTarsus)
sd(zTarsus)
hist(zTarsus)

set.seed(123)
znormal <- rnorm(1e+06)
hist(znormal, breaks = 100, col = 'lightsteelblue1')
par(mfrow = c(1,1))
hist(zTarsus, col = 'pink')
hist(znormal, breaks = 100, col = 'lightsteelblue1')
summary(znormal)
qnorm(c(0.025, 0.975))
pnorm(.Last.value)

par(mfrow = c(1,2))
hist(znormal, breaks = 100, col = 'peachpuff')
abline(v = qnorm(c(0.25, 0.5, 0.75)), lwd = 2, col = 'palevioletred4')
abline(v = qnorm(c(0.025, 0.975)), lwd = 2, lty = 'dashed', col = 'palevioletred4')
plot(density(znormal))
abline(v = qnorm(c(0.25, 0.5, 0.75)), col = 'darkcyan')
abline(v = qnorm(c(0.025, 0.975)), lty = 'dotted', col = 'mediumorchid')
abline(h = 0, lwd = 3, col = 'seagreen')
text(2, 0.3, '1.96', col = 'steelblue4', adj = 0)
text(-2, 0.3, '-1.96', col = 'steelblue4', adj = 1)

par(mfrow = c(1,1))
boxplot(d$Tarsus~d$Sex.1, col = c('lightpink1', 'lightblue4'), ylab='Tarsus length (mm)')