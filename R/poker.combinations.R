# function to calculate poker combinations
#' @import data.table

#' @export
poker.combinations <- function(repetitions = 100){
  results <- replicate(repetitions, poker.hand())
  results <- data.table(points = sapply(results, hand.evaluation))
  results <- results[, .N, by = points]
  results$freq <- results$N/sum(results$N)
  results <- results[, .(points, freq)]
  setorder(results, -freq)
  return(results)
}

