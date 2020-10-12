fitness.OptimumIsoPeaks <- function(object){
	
	object1 <- new("IsoPeaks",x = object@x);
	
	if(fitness(object1)== (length(object@x)*length(object@x))/4.0){
	
	return TRUE;
	
	}

	return FALSE;

}

fitness.OptimumPlateau <- function(object){
	
	object1 <- new("Plateau",x = object@x);
	
	if(fitness(object1)== (length(object@x)/3)){
	
	return TRUE;
	
	}

	return FALSE;

}