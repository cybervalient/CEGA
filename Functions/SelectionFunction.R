selection <- function(object,population) UseMethod("selection")

selection.default <- function(object,population) "Default Selection"

selection.Truncation<- function(object,population) {
	
	index <- order(population@fitness, decreasing = TRUE);
 	selPop <- data.frame(population@populationmatrix[index[1:object@selSize],],row.names=NULL);
	#print(selPop )
      fit <- population@fitness[index[1:object@selSize]];
  	#print(fit)
	selectedPopulation <- new("Population",populationmatrix=selPop,fitness=fit)

	return(selectedPopulation);
}
selection.Random<- function(object,population) {
	temp <- 1:nrow(population@populationmatrix);
 	index <- sample(temp);
	for(i in 1:object@selSize)
      	selectedPopulation[i,] <- population@populationmatrix[index[i],]
      return(selectedPopulation);
}
selection.Tournament<-function(object,population){

	 population <- population@populationmatrix;
	 popSize <- nrow(population);
	 indSize <- ncol(population@populationmatrix);
	 #fitness <- object@count@fitness;
	 temp <- 1:popSize;
	 indexes <- sample(temp);

	 r <- 1; i <- 1; j <- 1; m <- 2;
     while(i <= popSize){
     		k <- indexes[i];
			while(m <= popSize/object@selSize){
				if(population[indexes[i + m]]>population[k])
					k <- indexes[i + m];
			   m<-m+1;
            	}
			while(j <= indSize){
			  populationSelected[r,j]<-population[k,j];
			  j<-j+1;
			}
		populationSelected[r,] <- population[k,];
  		r <- r+1;
		i <- i+ popSize/object@selSize;
     
 }
 return(populationSelected);


}


