\name{snowFT-rand}
\title{Random Number Generation}
\alias{clusterSetupRNG.FT}
\alias{clusterSetupRNGstreamRepli}
\usage{
clusterSetupRNG.FT (cl, type = "RNGstream", streamper="replicate", \dots)
clusterSetupRNGstreamRepli (cl, seed=rep(12345,6), n, \dots)
}
\arguments{
  \item{cl}{Cluster object.}
  \item{type}{Type of the RNG. Currently, only \code{"RNGstream"} is supported. It initializes the
    L'Ecuyer's RNG.  }
  \item{streamper}{Mode of the inititalization. Value \code{"node"} initializes one random
    number stream per node.\cr Value \code{"replicate"} initializes one stream per replicate.}
  \item{\dots}{Arguments passed to the underlying function (see details
bellow).} 
  \item{seed}{A single integer or a vector of six integer values used as seed for the RNG.}
  \item{n}{Number of streams to be created. It should correspond to
    the number of replicates in the computation.}
}
\description{
  Initialize independent random number streams to be used in the
  cluster. It uses the L'Ecuyer's random number generator
  implemented in the \pkg{rlecuyer} package. 
}
\details{
  \code{clusterSetupRNG.FT} calls one of
  the following functions, while passing arguments \code{(cl, \dots)}:  For
  \code{streamper="node"}, the snow function \code{\link[snow]{clusterSetupRNGstream}} is
  called; For
  \code{streamper="replicate"}, the function
  \code{clusterSetupRNGstreamRepli} is called. In the latter case, the
  argument \code{n} has to be given that corresponds to the total number
  of streams created for the computation. This mode is used by \code{\link{clusterApplyFT}}. 
 Note that when using the function
  \code{\link{performParallel}}, 
  the user does not need to initialize the RNG separately, since it is
  accomplished within the function. 

  \code{clusterSetupRNGstreamRepli} loads the \pkg{rlecuyer} package
  and on each node it creates \code{n} streams. The
  streams are named by their ordinal number. 
}
\examples{
\dontrun{
# Generate 50 independent (normally distributed) random numbers 
# on 3 nodes using 10 RNG streams
cl <- makeClusterFT(3)
r <- 10
# reproducible results
for (i in 1:3) {
    clusterSetupRNG.FT(cl, streamper = "replicate", n = r, seed = 123)
    cat("\n")
    print(unlist(clusterApplyFT(cl, rep(5,r), rnorm, gentype = "RNGstream")[[1]]))
    
}

# non-reproducible results (method used in snow)
for (i in 1:3) {
    clusterSetupRNG.FT(cl, streamper = "node", seed = 123)
    cat("\n")
    print(unlist(clusterApplyFT(cl, rep(5,r), rnorm, gentype = "RNGstream")[[1]]))
}
stopClusterFT(cl)
}
}
\keyword{programming}
