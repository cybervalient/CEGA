configure<- function(eda,fitFun,init,popSize,indSize,selSize,elit,varMin,varMax,select,learn,samp,stopOperator) UseMethod("configure")

configure.EDA <- function(eda,fitFun,init,popSize,indSize,selSize,elit,varMin,varMax,select,learn,samp,stopOperator){

	if(init=="Discrete"){
	  edaDomain = "EDADiscrete";
  }else{
	  edaDomain = "EDAContinuous";
	}

	newEDA <- new(edaDomain);
	
	initOperator   <- new(init,populationSize=popSize,individualSize=indSize,variableMinimum=varMin,variableMaximum=varMax);
	
	initialPopMatrix <- initiation(initOperator);
	
	evalOperator  <-new("EvaluateOperator" ,fitnessFunction=fitFun);
	
	fitness <- evaluate(evalOperator,initialPopMatrix);

	population  <- new("Population",populationmatrix=initialPopMatrix ,fitness=fitness)
	learningOperator <- learn
	selectOperator <- new(select,selSize=selSize)
	sampOperator   <- new(samp,sampleSize= nrow(initialPopMatrix),varmin=varMin,varmax=varMax,elitism=elit)
	
	newEDA@initiationOperator <- initOperator
	newEDA@selectionOperator  <- selectOperator
	newEDA@learningOperator   <- learningOperator 
	newEDA@samplingOperator   <- sampOperator
	newEDA@evaluateOperator   <- evalOperator
	newEDA@stopCondition      <- stopOperator
	
	execute(newEDA,population);
}