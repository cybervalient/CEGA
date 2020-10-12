initiation <- function(object) UseMethod("initiation")
initiation.default <- function(object) "Default Initiation"

initiation.Discrete <- function(object) {
	
	population <- matrix(nrow = object@populationSize, ncol = object@individualSize);
	
	for (var in 1:object@individualSize) {
		population[,var] <- sample(c(object@variableMinimum[var]:object@variableMaximum[var]), nrow(population), rep=TRUE);
	}
  as.data.frame(population);
}

initiation.Continuous <- function(object) {
	population <- matrix(nrow = object@populationSize, ncol = object@individualSize);
	
	for (var in 1:object@individualSize) {
		population[,var] <- runif(nrow(population), min=object@variableMinimum[var], max=object@variableMaximum[var]);
	}

	as.data.frame(population);
}