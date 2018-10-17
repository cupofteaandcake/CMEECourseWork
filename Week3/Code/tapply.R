x <- 1:20
x

y <- factor(rep(letters[1:5], each = 4))
y

tapply(x, y, sum)