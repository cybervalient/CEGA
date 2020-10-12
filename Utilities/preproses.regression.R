preproses.max <- function(data) {
	max.global <<- c(rep(0, ncol(data)));

	for (i in 1:ncol(data)) {
		max.global[i] <<- max(data[,i]);
	}
}

preproses.min <- function(data) {
	cc = ncol(data);
	min.global <<- c(rep(0, cc));

	for (i in 1:cc) {
		min.global[i] <<- min(data[,i]);
	}
}
