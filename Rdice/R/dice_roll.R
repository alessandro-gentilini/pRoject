# function to simulate a die roll

dice.roll <- function(N = 6, rolls = 10, weights){
  if(missing(weights)){
    # case of a fair die
    values <- sample(1:N, rolls, replace = TRUE, prob = NULL)
    frequencies <- as.data.table(table(values))
    setnames(frequencies, c("values", "occurrencies"))
    frequencies$freq <- frequencies$occurrencies/sum(frequencies$occurrencies)
  } else {
    e <-tryCatch(
      {
        !(length(weights)==N & sum(weights)==1)
      },
      error = function(){
        return(TRUE)
      }
    )
    if(!e){
      # actual function if no exception is thrown
      values <-sample(1:N, rolls, replace = TRUE, prob = weights)
      frequencies <- as.data.table(table(values))
      setnames(frequencies, c("values", "occurrencies"))
      frequencies$freq <- frequencies$occurrencies/sum(frequencies$occurrencies)
    } else {
      stop("The vector of weights must be of the same lenght as the number of faces N. Also, the weights must sum up to 1.")
    }
  }
  list(results = values, frequencies = frequencies)
}


