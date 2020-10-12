sampling <- function(object,learning,populationSelected) UseMethod("sampling")

sampling.default <- function(object,learning,populationSelected) "Sampling Default"

sampling.Gaussian <- function(object,learning,populationSelected) {
	
	sampSize <- object@sampleSize-object@elitism
		
	# simulate multinormal data of sample size n

	sigsvd <- svd(learning)
	Y <- t(sigsvd$v %*% (t(sigsvd$u) * sqrt(sigsvd$d)))
	samplePopulation <- matrix(rnorm(sampSize  * ncol(learning)), nrow =sampSize) %*% Y

	as.data.frame(samplePopulation)
}

#Simulation in corpcor package pag. 6
sampling.GaussianSHR <-function(object, learning, populationSelected) {

  sampSize <- object@sampleSize - object@elitism
 
  # simulate multinormal data of sample size n

  sigsvd = fast.svd(learning);
  Y = t(sigsvd$v %*% (t(sigsvd$u) * sqrt(sigsvd$d)));
  samplePopulation = matrix(rnorm(sampSize * ncol(learning)), nrow = sampSize ) %*% Y;
  
  for (i in 1:sampSize) {
    samplePopulation[i,] <- ifelse(samplePopulation[i,] > object@varmin, ifelse(samplePopulation[i,] < object@varmax, samplePopulation[i,], object@varmax), object@varmin)
  }
     as.data.frame(samplePopulation)
  }

sampling.RBN <- function(object, learning, populationSelected) {
  sampSize <- object@sampleSize - object@elitism
	dfPop <- convert.factor(populationSelected);

  samplePopulation <- rbn(learning, sampSize, dfPop);
	
	for (i in 1:nrow(samplePopulation )) {
		for (j in 1:ncol(samplePopulation )) {
			if (is.na(samplePopulation [i,j]) == TRUE) {
				samplePopulation [i,j] = 0;
			} 
		}
	}
	 
	 data.frame(samplePopulation,row.names=NULL);
	
}
