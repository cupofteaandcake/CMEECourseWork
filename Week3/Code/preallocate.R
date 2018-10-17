no_allocate <- function(a){
    a <- NA
    for (i in 1:1000000) {
        a <- c(a, i)
    }
    print(a)
}
# preallocate space in RAM for any form of data
pre_allocate <- function(a){
    a <- rep(NA, 1000000)
    for (i in 1:1000000){
        a[i] = 10
    }
}

# more than 2 min
print(system.time(no_allocate(a)))

# 0.048s
print(system.time(pre_allocate(a)))