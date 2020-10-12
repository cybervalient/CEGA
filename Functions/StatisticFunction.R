statistics <- function(object,iter) UseMethod("statistics")

statistics.default <- function(object,iter) "Default statistics" 

statistics.Population <- function(object,iter) {
	#print(object@populationmatrix)
	#print(object@fitness)
	m <- which.max(object@fitness);
	#print(m)
	print(paste("Iteration", iter));
        cat("\n");
	print("Best individual");
	print(object@populationmatrix[m,])
	cat("\n");
        print("Best fitness:");
	print(max((object@fitness)));
	cat("\n");
	print('--------------------------------------------------------')
	cat("\n");
	flush.console();
}