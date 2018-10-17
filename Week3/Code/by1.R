attach(iris)
iris

by(iris[,1:2], iris$Species, colMeans)

by(iris[,1:2], iris$Petal.Width, colMeans)