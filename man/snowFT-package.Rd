\name{snowFT-package}
\alias{snowFT-package}
\alias{snowFT}
\docType{package}
\title{
Fault Tolerant Simple Network of Workstations
}
\description{
Extension of the snow package supporting fault tolerant
and reproducible applications, dynamic cluster resizing, as well as supporting easy-to-use parallel programming - only one function is needed. 
It supports the MPI and the socket communication layers.
}
\details{

\tabular{ll}{
Package: \tab snowFT\cr
Version: \tab 1.6-0\cr
License: \tab GPL\cr
}

The main function of this package, \code{\link{performParallel}}, handles all tasks that are necessary for evaluating a user-defined function in parallel. These include creating a cluster, initializing nodes, handling a random number generator, processing the given function on the cluster and cleaning up. In the very basic settings (i.e. when using with the socket layer), no additional software is necessary. The package can be used on a single multi-processor/core machine, homogeneous cluster, or a heterogeneous group of computers.

The package supports creating and handling a \pkg{snow} cluster that is:
\enumerate{
\item Fault tolerant: The master checks repeatedly for failures in its waiting time and initiates a failure recovery if needed. (This feature has been implemented for the PVM layer. Unfortunately, the PVM layer had to be switched off due to the \pkg{rpvm} package not being currently maintained.)
\item Load balanced AND produces reproducible results: one stream of random numbers associated with one replicate (instead of one stream per node as handled by \pkg{snow} and \pkg{parallel}).
\item Computationally transparent: Currently processed replicates and failed replicates stored into files. Allows defining a function that is called after each given number of replicates.
\item Dynamically resizeable: The cluster size is stored in a file which is read by the master repeatedly. In case of a modification the cluster is updated. (Not available for MPI.)
\item Administration overhead minimized: All administration is managed by the master in its waiting time. (Note that there is a time-overhead for creating and destroying the cluster, as well as the RNG initialization. Thus, simple operations, such as the example below, will not gain from running in parallel.)
\item Allows running processes sequentially with the same random numbers as it would in parallel. Thus, results can be compared between the two modes.
\item Easy to use: All features, including creating the cluster, RNG initialization and clean-up, are available via one single function - \code{\link{performParallel}}.
}
}
\author{
Hana Sevcikova, A. J. Rossini

Maintainer: Hana Sevcikova <hanas@uw.edu>
}
\references{
http://www.stat.washington.edu/hana/parallel/snowFT-doc.pdf
}
\keyword{programming}
\keyword{ package }
\seealso{
\code{\link{performParallel}}, \code{\link[snow]{clusterCall}}
}
\examples{
\dontrun{
# generates 500 times 1000 normally distributed random numbers on 5 nodes
# (all localhost)
res <- performParallel(5, rep(1000, 500), fun = rnorm, cltype = "SOCK")
print(mean(unlist(res)))

# View cluster usage
# number of physical nodes
P <- parallel::detectCores(logical = FALSE)
t <- snow::snow.time(performParallel(P, rep(1e6, 50), 
        fun = function(x) median(rnorm(x)), cltype = "SOCK"))
plot(t)
}

}
