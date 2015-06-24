\name{snowFT-rand}
\title{Random Number Generation}
\alias{clusterSetupRNG.FT}
\alias{clusterSetupRNGstreamRepli}
\usage{
clusterSetupRNG.FT (cl, type = "RNGstream", streamper="replicate", ...)
clusterSetupRNGstreamRepli (cl, seed=rep(12345,6), n, ...)
}
\arguments{
  \item{cl}{Cluster object.}
  \item{type}{Type of the RNG. Currently, only \code{"RNGstream"} is supported. It initializes the
    L'Ecuyer's RNG.  }
  \item{streamper}{Mode of the inititalization. Value \code{"node"} initializes one random
    number stream per node.\cr Value \code{"replicate"} initializes one stream per replicate.}
  \item{...}{Arguments passed to the underlying function (see details
bellow).} 
  \item{seed}{Vector of six integer values used as seed for the RNG.}
  \item{n}{Number of streams to be created. It should correspond to
    the number of replicates in the computation.}
}
\description{
  Initialize independent random number streams to be used in the
  cluster. It uses either the L'Ecuyer's random number generator
  (package rlecuyer required). 
}
\details{
  \code{clusterSetupRNG.FT} calls one of
  the following functions, while passing arguments \code{(cl, ...)}:  For
  \code{streamper="node"}, the snow function \code{\link[snow]{clusterSetupRNGstream}} is
  called; For
  \code{streamper="replicate"}, the function
  \code{clusterSetupRNGstreamRepli} is called. In the latter case, the
  argument \code{n} has to be given that corresponds to the total number
  of streams created for the computation. This mode is used by \code{\link{clusterApplyFT}}. 
 Note that using the function
  \code{\link{performParallel}}, 
  the user does not need to initialize the RNG separately, since it is
  accomplished within the function. 

  \code{clusterSetupRNGstreamRepli} loads the \code{rlecuyer} package
  and on each node it creates \code{n} streams. The
  streams are named by their ordinal number. 
}
\examples{
\dontrun{
cl <- makeClusterFT(3)
r<-10
clusterSetupRNG.FT(cl, streamper="replicate",n=r, seed=rep(1,6))
res<-clusterApplyFT(cl,rep(5,10),rnorm)
stopCluster(res[[2]])
print(res[[1]])
  }
}
\keyword{programming}
