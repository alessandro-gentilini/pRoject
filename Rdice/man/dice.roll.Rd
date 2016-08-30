\name{dice.roll}
\alias{dice.roll}
\title{Dice simulator}
\description{Simulates rolling of a die}
\usage{
dice.roll(N, rolls, weights)
}
\arguments{
  \item{N}{ the number of faces the die has; if unspecified, it
            defaults to 6.}
  \item{rolls}{ the number of times to roll the die; if unspeciefid, it
            defaults to 1.}
  \item{weights}{ a vector of probability weights to assign to each
                  face of the die; if unspecified, it defaults to a fair
                  die with weights $1/N$. If specified, its lenght must
                  obviously be $N$ and all the single weights must sum up to 1.}
}
%- maybe also 'usage' for other objects documented here.
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
 \item{results}{ the numerical results rolled.}
 \item{frequencies}{ a table containing each single occurrency
                    and the corresponding frequencies.}
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Gennaro Tedesco
}
\note{
It's awesome
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function ()
{
    print("rolling a die...")
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
