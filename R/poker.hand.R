# function to simulate poker hands

is.high.card <- function(hand){
  return(length(unique(hand$figures))==5 &&
           (max(hand$values)-min(hand$values))!=4)
}


is.pair <- function(hand){
  return(max(table(hand$figures))==2 &&
           length(unique(hand$figures))==4)
}


is.double.pair <- function(hand){
  return(max(table(hand$figures))==2 &&
           length(unique(hand$figures))==3)
}


is.three.kind <- function(hand){
  return(max(table(hand$figures))==3 &&
           min(table(hand$figures))!=2)
}


is.straight <- function(hand){
  return(length(unique(hand$figures == 5)) &&
           (max(hand$values)-min(hand$values))==4 &&
           length(unique(hand$suits))!=1)
}


is.flush <- function(hand){
  return(length(unique(hand$suits))==1)
}


is.full.house <- function(hand){
  return(max(table(hand$figures))==3 &&
           min(table(hand$figures))==2)
}

is.four.kind <- function(hand){
  return(max(table(hand$figures))==4)
}


is.straight.flush <- function(hand){
  return(length(unique(hand$figures == 5)) &&
           (max(hand$values)-min(hand$values))==4 &&
           is.flush(hand))
}


is.royal.flush <- function(hand){
  return(is.straight.flush(hand) &&
           "A"%in%hand$figures)
}


# function to evaluate the hand
hand.evaluation <- function(hand){
  if(is.high.card(hand)){
    return("high card")
  } else if (is.pair(hand)){
    return("pair")
  } else if(is.double.pair(hand)){
    return("double pair")
  } else if(is.three.kind(hand)){
    return("three of a kind")
  } else if(is.straight(hand)){
    return("straight")
  } else if(is.flush(hand)){
    return("flush")
  } else if(is.full.house(hand)){
    return("full house")
  } else if(is.four.kind(hand)){
    return("four of a kind")
  } else if(is.straight.flush(hand)){
    return("straight flush")
  } else if(is.royal.flush(hand)){
    return("royal flush")
  } else {
    return("unspecified")
  }
}


# poker hand being dealt
poker.hand <- function(){
  figures  <- rep(c(2:10, "J", "Q", "K", "A"),4)
  values   <- rep(c(2:10, 11, 12, 13, 14),4)
  suit     <- c(rep("D",13),rep("C",13),rep("H",13),rep("S",13))
  deck     <- data.table(figures, suit, values)
  hand     <- deck[sample(.N, 5)]
  return_object <- list(hand=hand)
  return_object
}


print.pokerHand <- function(x, ...){
  cat("Call:\n")
  print(x$call)
  #output <- data.table(figures = x$hand$figures, suit = x$hand$suit)
  #cat("\n The poker hand is", x$hand,"\n")
}
