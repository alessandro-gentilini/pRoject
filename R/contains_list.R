
# function to check if a list "b" contains another list "s"

fun.contains <- function(b, s){
	all(s %in% b) && 
		length(s[duplicated(s)]) <= length(b[duplicated(b)]) &&
		(if(length(s[duplicated(s)])>0) fun.contains(b[duplicated(b)],s[duplicated(s)]) else 1)
}