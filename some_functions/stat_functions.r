 
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


# ----------------------------------------------------
# prototype of ggplot theme

if(FALSE){
morley <- head(morley,20)
p <- ggplot(morley, aes(x=Run))
p <- p + theme(panel.grid.major = element_blank(), 
               panel.grid.minor = element_blank(),
               panel.background = element_rect(fill 
                                               = '#002b36'),
               axis.line = element_line(colour = "black"),
               legend.text=element_text(size=16),
               legend.title=element_blank(),
               axis.title.x = element_text(vjust=0, size=16),
               axis.title.y = element_text(vjust=1, size=16),
               plot.title   = element_text(vjust=1.5, size=20)) 
p <- p + geom_line(aes(y=Speed), colour = '#268bd2' )
p <- p + geom_point(aes(y=Speed), colour = '#cb4b16')
p <- p + scale_x_discrete(breaks = morley$Run)
p <- p + labs(title = "Morley runs")
p <- p + labs(x = "Runs")
p <- p + labs(y = "Speed")
show(p)
}

