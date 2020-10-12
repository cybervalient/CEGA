stop <- function(object,population) UseMethod("stop")

stop.StopCondition <- function(object,population){
    #"Default stop"
     return(FALSE);
} 

stop.Optimum<- function(object,population) {
	m <- max(population@fitness);
	f <- FALSE;

	if (abs(m - object@optimum) <= object@epsilon)
		f <- TRUE;

	f;
}

stop.Found<- function(object,population) {
	
	m <- max(population@fitness);
	f = FALSE;

	if (m==object@found){
		f <- TRUE;	
       }
	f;
}

stop.Eq<- function(object,population) {
	matrix<-population@populationmatrix;
	f = TRUE;
	for(i in 2:nrow(matrix))
		if(!identical(matrix[i,],matrix[1,]))
		return(FALSE)
	f <- !identical
	f;
}

stop.Range<- function(object,population) {
	popSize <-nrow(population@populationmatrix);
	best    <-population@fitness[1];
	fitness <- population@fitness;
	for(i in 2:popSize)
		if(fitness[i]>best)
		  best<- fitness[i];
	f<- abs(best)<= object@alpha;
	f;
}

stop.Mean<- function(object,population) {
	popSize <-nrow(population@populationmatrix);
	fitness <- population@fitness;
	sum <- 0;
	for(i in 1:popSize)
	   sum <- sum + fitness[i];
	object@invocCount <- object@invocCount+1;
	object@prevMean <- object@lastMean;
	object@lastMean <- sum/popSize;
	if(object@invocCount < 2)
		return(FALSE);
	
	abs(lastMean - prevMean) <= object@delta;
}
stop.Target<- function(object,population) {
	population <-population@populationmatrix;
	popSize <-nrow(population);
	indSize <-ncol(population@populationmatrix);
	
	for(i in 1:popSize){
		if(identical(population[i,],object@target))		
			#position =i;
			return(TRUE);
		}
	return(FALSE);
	
}









