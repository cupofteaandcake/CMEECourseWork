#!/usr/bin/env Rscript
# Runs the stochastic (with gaussian fluctuations) Ricker Eqn .

# __appname__ = Vectorize2.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list=ls())
graphics.off()

stochrick<-function(p0=runif(1000, .5, 1.5), r=1.2, K=1, sigma=0.2, numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  for (pop in 1:length(p0)) #loop through the populations
  {
    for (yr in 2:numyears) #for each pop, loop through the years
    {
      N[yr,pop]<-N[yr-1,pop]*exp(r*(1-N[yr-1,pop]/K)+rnorm(1,0,sigma))
    }
  }
 return(N)
}
plot(stochrick())
print("Unvectorised stochastic Ricker model takes:")
print(system.time(stochrick(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)))

# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 

stochrickvect <- function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100) {
  #vectorised stochastic Ricker eqn
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  #can remove outer loop as R naturally iterates through each column when it runs the row
  func <- for (yr in 2:numyears)
  {
    N[yr,] <- N[yr-1,]*exp(r*(1-N[yr-1,]/K)+rnorm(1000,0,sigma))
  }
  return(N)
}

print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))