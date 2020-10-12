execute <- function(eda,population) UseMethod("execute")
execute.EDA <- function(eda,population) "Run default"

execute.EDAContinuous <- function(eda,population) {
      
	statistics(population,1);

	for (iter in 2:eda@stopCondition@iterations) {
		
		if (stop(eda@stopCondition,population))
			break;

		selPop <- selection(eda@selectionOperator, population);
		
		selPop@populationmatrix <- as.data.frame(checkCont(selPop));

		learning <- learning(eda@learningOperator, convert.numeric(selPop@populationmatrix));
			
		sampMatrix <- sampling(eda@samplingOperator,learning, convert.numeric(selPop@populationmatrix));
	
		fitness <- evaluate(eda@evaluateOperator, sampMatrix);
	
		if(eda@samplingOperator@elitism==0){
			newMatrixPop=sampMatrix;
			newFitness=fitness; 
		}else{
			newMatrixPop=data.frame(rbind(selPop@populationmatrix[(1):(eda@samplingOperator@elitism),],sampMatrix),row.names = NULL,check.names=TRUE,stringsAsFactors = FALSE );
			newFitness=c(selPop@fitness[1:eda@samplingOperator@elitism],fitness)
    }
		newPopulation <- new("Population",populationmatrix=newMatrixPop,fitness=as.array(newFitness));

		statistics(newPopulation,iter);	
    population <- newPopulation;		
	}	
}


execute.EDADiscrete <- function(eda,population) {     
  statistics(population,1);	
 
	for (iter in 2:eda@stopCondition@iterations) {		
    if (stop(eda@stopCondition,population))
		  break;

		selPop <- selection(eda@selectionOperator,population);
		selPop@populationmatrix <- check(selPop);
		
		dfPop <- convert.factor(selPop@populationmatrix);
    learning <- learning(eda@learningOperator, dfPop);
		
    sampMatrix <- sampling(eda@samplingOperator,learning,selPop@populationmatrix);
	
		fitness <- evaluate(eda@evaluateOperator,convert.numeric(sampMatrix));
	
		if(eda@samplingOperator@elitism==0){
			newMatrixPop=sampMatrix;
			newFitness=fitness; 
		}else{
			newMatrixPop=data.frame(rbind(selPop@populationmatrix[(1):(eda@samplingOperator@elitism),],sampMatrix),row.names = NULL,check.names=TRUE,stringsAsFactors = FALSE );
			newFitness=c(selPop@fitness[1:eda@samplingOperator@elitism],fitness)
		}
		newPopulation <- new("Population",populationmatrix=newMatrixPop,fitness=as.array(newFitness));
	
		statistics(newPopulation,iter);	
    population <- newPopulation;	
	}	
}		
