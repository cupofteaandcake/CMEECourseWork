require(Publish)

d1 <- subset(d, d$Tarsus!='NA')
sqrt(var(d1$Tarsus)/length(d1$Tarsus))
d1b <- subset(d1, d1$Year==2001)
sqrt(var(d1b$Tarsus)/length(d1b$Tarsus))
length(d1)
length(d1b)
ci.mean(d1$Tarsus)
ci.mean(d1b$Tarsus)

d2 <- subset(d, d$Bill!='NA')
sqrt(var(d2$Bill)/length(d2$bill))
d2b <- subset(d2, d2$Year==2001)
sqrt(var(d2b$Tarsus)/length(d2b$Tarsus))
length(d2)
length(d2b)
ci.mean(d2$Bill)
ci.mean(d2b$Bill)

d3 <- subset(d, d$Mass!= 'NA')
sqrt(var(d3$Mass)/length(d3$Mass))
d3b <- subset(d3, d3$Year==2001)
sqrt(var(d3b$Mass)/length(d3b$Mass))
length(d3)
length(d3b)
ci.mean(d3$Mass)
ci.mean(d3b$Mass)

d4 <- subset(d, d$Wing!='NA')
sqrt(var(d4$Wing)/length(d4$Wing))
d4b <- subset(d4, d4$Year==2001)
sqrt(var(d4b$Wing)/length(d4b$Wing))
length(d4)
length(d4b)
ci.mean(d4$Wing)
ci.mean(d4b$Wing)

#################

t.test(d1b$Tarsus, mu=18.5)

d5 <- subset(d, d$Year==2001)
t.test(d5$Tarsus~d5$Sex, na.rm = TRUE)

t.test(d1$Tarsus~d1$Sex, na.rm = TRUE)

##################
d <- read.table('../Data/SparrowSize.txt', header = TRUE)

d4 <- subset(d, d$Wing!='NA')
mean(d4$Wing)
d4b <- subset(d4, d4$Year==2001)
t.test(d4b$Wing, mu=77.4) #p=0.26, doesn't differ from mean

t.test()