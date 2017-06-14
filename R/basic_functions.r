
# ------------------------------------------
# a collection of useful non-in-built
# functions for data science and data mining
# ------------------------------------------

# quarks data table
set.seed(1)
lab      <- sample (LETTERS[1:6], 100, replace = TRUE)
flavour  <- sample(c("up", "down", "charme", "strange",
                     "top", "bottom"), 100, replace = TRUE)
S_z      <- sample(c("1/2", "-1/2"), 100, replace = TRUE)
quarks   <- data.table(lab, flavour, S_z)


# first k factorials, namely n*(n-1)*...*(n-k+1)
k_factorial <- function(n, k){
  if(k==1){
    return(1)
  } else {
    values <- ((n-k+1)/n)*k_factorial(n,k-1)
    values
  }
}


# shapiro p.value function
shapiro.p.value <- function(my.column) {
    my.p.value <- '0.05'
    if(shapiro.test(my.column)[2] < my.p.value){
        return("rejected")
    } else {
        return("not rejected")
    }
}


# NA to zeros function
na2zero <- function(x) {
    x[] <- lapply(x,function(x){x[is.na(x)] <- 0; x})
    x
}


# function to calculate the mode
mode <- function(x) {
    ux <- unique(x)
    tab <- tabulate(match(x, ux))
    ux[tab == max(tab)]
}


# a method to find outliers of a set of data
# using the k-means clustering
outlier.by.clustering <- function(df,N,M){
    cluster <- kmeans(df, centers = N)
    centres <- cluster$centers[cluster$cluster,]
    distances <- sqrt(rowSums((df-centres)^2))
    outliers  <- head(df[order(distances, decreasing = TRUE),],M)
    return(outliers)
}



