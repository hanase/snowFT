#
# MPI Implementation
#

recvOneDataFT.MPIcluster <- function(cl, type='b', time=0) {
  # non-blocking receive (type='n') and timeout receive (type='t')
  # not implemented.
    return(snow::recvOneData(cl))
    # 2023/09/20
    # In the newest R-devel version, the "parallel" function recvOneData is 
    # not internal anymore - it is now exported via the NAMESPACE.
    # However it is not the case in the current (stable) version of R. 
    # Thus, in the future the above call should be changed to 
    # return(parallel::recvOneData(cl))
}

addtoCluster.MPIcluster <- function(cl, spec, ...,
                                    options = defaultClusterOptions) {
  stop("Function addtoCluster is not implemented for MPI")
}

repairCluster.MPIcluster <- function(cl, nodes, ...,
                                     options = defaultClusterOptions) {
  stop("Function repairCluster is not implemented for MPI")
}

is.manageable.MPIcluster <- function(cl) {
	return (c(cluster.size=FALSE, monitor.procs=TRUE, repair=FALSE))
}

processStatus.MPInode <- function(node) {
  stop("Function processStatus is not implemented for MPI")
}

getNodeID.MPInode <- function(node) {
  return(node$rank)
}

do.administration.MPIcluster <- function(cl, clall, d, p, it, n, manage, mngtfiles, 
									x, frep, freenodes, ...) {
	free.nodes <- FALSE
	updated.values <- manage.replications.and.cluster.size(cl, clall, p, n, manage, mngtfiles, 
									freenodes, ...)
	if ((length(updated.values$freenodes) > 0) && (it <= n)) free.nodes <- TRUE

	return(c(updated.values, list(frep=frep, d=d, is.free.node=free.nodes)))
}