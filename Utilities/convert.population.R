convert.factor <- function(population) {	
	dataPopulation <- as.data.frame(x=population, stringsAsFactors=TRUE);
	for (j in 1:ncol(dataPopulation)) {
		dataPopulation[,j] <- as.factor(dataPopulation[,j]);
	}

  dataPopulation;
}

convert.real <- function(population) {	

	dataPopulation <- as.data.frame(x=population);
	

	for (j in 1:ncol(dataPopulation)) {
		
		dataPopulation[,j] <- as.real(dataPopulation[,j]);
		
	}
	
	
	dataPopulation;
}

convert.numeric <- function(dataPopulation) {	
	for (j in 1:ncol(dataPopulation)) {
		dataPopulation[,j] <- as.numeric(dataPopulation[,j]);
	}
	
	dataPopulation <- dataPopulation -1;
	dataPopulation;
}

check <- function(popSelect){
	for (j in 1:ncol(popSelect@populationmatrix)) {
	  if (nlevels(as.factor(popSelect@populationmatrix[,j])) < 2) {
      if (as.integer(popSelect@populationmatrix[nrow(popSelect@populationmatrix),j]) == 0)
	      popSelect@populationmatrix[nrow(popSelect@populationmatrix),j] = 1
      else
        popSelect@populationmatrix[nrow(popSelect@populationmatrix),j] = 0
	  }
	}
  
  popSelect@populationmatrix
}

checkCont <- function(popSelect){
  cont=0;
 #print(popSelect@populationmatrix)

 
	for (j in 1:ncol(popSelect@populationmatrix)) {
              temp <- popSelect@populationmatrix[nrow(popSelect@populationmatrix),j];
              check <- popSelect@populationmatrix[1,j];
		
		for(i in 2:nrow(popSelect@populationmatrix)){
                 
			if(popSelect@populationmatrix[i,j]!= check){
  			break;
	    }else{
                    cont=cont+1;
	    }
	  }
			#print(cont)
             if(cont==(nrow(popSelect@populationmatrix)-1)){
		  
              popSelect@populationmatrix[nrow(popSelect@populationmatrix),j] = as.double(temp) + 0.0000000000001;
		}
		cont=0;
	}
     #print(popSelect@populationmatrix)
     popSelect@populationmatrix

  }