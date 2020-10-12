evaluate <- function(object,popMatrix)UseMethod("evaluate")

evaluate.default <- function(object,popMatrix) "Evaluate" 


evaluate.EvaluateOperator <- function(object,popMatrix) {
	
	popSize <- nrow(popMatrix);
	evals <- array(NA,dim=c(popSize));
	fit <- object@fitnessFunction;

	for (i in 1:popSize) {
	
            fit@x = as.numeric(c(popMatrix[i,]));
		evals[i] = fitness(fit);
	}
   return(evals)

}
