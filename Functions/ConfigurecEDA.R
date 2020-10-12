config<- function(ceda,fitFun,init,lattice, neighborhood,indSize,selSize,elit,varMin,varMax,select,learn,samp,stopOperator) UseMethod("config")

config.cEDA <- function(ceda,fitFun,init,lattice, neighborhood,indSize,selSize,elit,varMin,varMax,select,learn,samp,stopOperator){
  if(init=="Discrete"){
    edaDomain = "cEDADiscrete";
  }else{
    edaDomain = "cEDAContinuous";
  }
  
  newcEDA <- new(edaDomain);
  
  popSize = lattice@totalRows * lattice@totalCols * lattice@totalRowsPerCell * lattice@totalColsPerCell;
  
  initOperator   <- new(init,populationSize=popSize,individualSize=indSize,variableMinimum=varMin,variableMaximum=varMax);
  
  initialPopMatrix <- initiation(initOperator);
  
  evalOperator  <-new("EvaluateOperator" ,fitnessFunction=fitFun);
  
  fitness <- evaluate(evalOperator,initialPopMatrix);
  
  population  <- new("Population",populationmatrix=initialPopMatrix ,fitness=fitness)
 
  learningOperator <- learn
  selectOperator <- new(select,selSize=selSize)
  sampOperator   <- new(samp,sampleSize= nrow(initialPopMatrix),varmin=varMin,varmax=varMax,elitism=elit)
  
  newcEDA@initiationOperator <- initOperator
  newcEDA@selectionOperator  <- selectOperator
  newcEDA@learningOperator   <- learningOperator 
  newcEDA@samplingOperator   <- sampOperator
  newcEDA@evaluateOperator   <- evalOperator
  newcEDA@stopCondition      <- stopOperator
  newcEDA@neighborhood       <- neighborhood
  newcEDA@latticeConfiguration <- lattice
  
  #execute CEDA
  executeSync(newcEDA, population);
  
  }