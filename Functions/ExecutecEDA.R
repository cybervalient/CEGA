executeSync <- function(ceda,totalpopulation) UseMethod("executeSync")

executeSync.cEDA <- function(ceda,totalpopulation) "Run default"

executeSync.cEDAContinuous <- function(ceda,totalpopulation) {
  statistics(totalpopulation,1)
}

executeSync.cEDADiscrete <- function(ceda, totalpopulation) { 
  #Print the statistic for the grid
  neighborhood<-ceda@neighborhood
  points <- length(neighborhood@xradio)
  popLength <-points*ceda@latticeConfiguration@totalRowsPerCell*ceda@latticeConfiguration@totalColsPerCell
  totalpopLength <- ceda@latticeConfiguration@totalRows*ceda@latticeConfiguration@totalCols*ceda@latticeConfiguration@totalRowsPerCell*ceda@latticeConfiguration@totalColsPerCell
  sizeCell <- popLength/points
  individualsize <-ceda@initiationOperator@individualSize
  indSize <- ncol(totalpopulation@populationmatrix);
  popSize <- nrow(totalpopulation@populationmatrix); 
  syncrone = FALSE
  globaling = FALSE
  
  statistics(totalpopulation,1)
  
  if(!globaling){
    sizeL <- popLength 
  }
  else
  {
    sizeL <- totalpopLength
  }
  
  if(ceda@selectionOperator@selSize > sizeL){
    ceda@selectionOperator@selSize <- sizeL
  }
  
  
  for (iter in 2:ceda@stopCondition@iterations) {
    if (stop(ceda@stopCondition, totalpopulation))
      break;
    if(!globaling){
      #Local Strategy Learning
    if(syncrone){
    #Create a New Population
    totalpopMatrix<- data.frame(matrix(nrow = totalpopLength, ncol = indSize))
    totalfitness <- array(dim = totalpopLength)
    countPop <- 1
    #For each cell of the Grid
    #Explorate the Grid Syncroned
    for (nRow in 1: ceda@latticeConfiguration@totalRows){
      for (nCol in 1: ceda@latticeConfiguration@totalCols){
        m<-1
        popMatrix <- data.frame(matrix(nrow=popLength, ncol=indSize))
        fit <- array(dim = popLength)
       
        #For each neigborhood
        for(n in 1:points){
         #Obtain the cell
         nRow <- nRow + neighborhood@yradio[n]
         if(nRow == 0 || ((nRow)%%ceda@latticeConfiguration@totalRows)==0){
           nRow <- nRow - 1
         }
         
         
         nCol<- nCol + neighborhood@xradio[n]
         if(nCol == 0 || ((nCol)%%ceda@latticeConfiguration@totalCols)==0){
           nCol <- nCol - 1
         }
         
         
         cell <- ((nRow)%%ceda@latticeConfiguration@totalRows) * ((nCol)%%ceda@latticeConfiguration@totalCols)  
         for(cn in 0:(sizeCell-1)){
           j<-1
           while(j <= indSize){
            popMatrix[m,j]=totalpopulation@populationmatrix[(cell+cn),j]
            j<-j+1
           }
           fit[m]=totalpopulation@fitness[(cell+cn)]
           m<-m+1
         }
         
        }
        print("-------Total population----")
        print(totalpopulation)
        print("------------------")
       
         #Run EDA
        population <- new("Population",populationmatrix= data.frame(popMatrix), fitness=array(fit))
        
        #Select 
       
        selPop <- selection(ceda@selectionOperator,population);
        selPop@populationmatrix <- check(selPop);
        dfPop <- convert.factor(selPop@populationmatrix);
        
        #Learning
        learning <- learning(ceda@learningOperator, dfPop);
        sampMatrix <- sampling(ceda@samplingOperator,learning,selPop@populationmatrix);
  
        #Evaluate
        fitness <- evaluate(ceda@evaluateOperator,convert.numeric(sampMatrix));
       
        if(ceda@samplingOperator@elitism==0){
          newMatrixPop=sampMatrix;
          newFitness=fitness; 
        }else{
          newMatrixPop=data.frame(rbind(selPop@populationmatrix[(1):(ceda@samplingOperator@elitism),],sampMatrix),row.names = NULL,check.names=TRUE,stringsAsFactors = FALSE );
          newFitness=c(selPop@fitness[1:ceda@samplingOperator@elitism],fitness)
        }
        
        #generate the new points (Size of cell)
        index <- order(newFitness, decreasing = TRUE);
        #Create new cell and save into new Grid
        for(np in 1:sizeCell){
          j<-1
          while(j <= indSize){
            totalpopMatrix[countPop,j] = newMatrixPop[index[np],j]
            j<-j+1
          }
          
          totalfitness[countPop] = newFitness[index[np]] 
          countPop <- countPop + 1
        }
        
      }
    }
    #Print the statistic for the grid
    newPopulation <- new("Population",populationmatrix=data.frame(totalpopMatrix),fitness=array(totalfitness));
    totalpopulation <- newPopulation;
    statistics(newPopulation,iter);
    }
    else{
      #Asyncronized
      for (m in 1: ceda@latticeConfiguration@totalRows){
        nRow = floor(runif(1,min = 1, max = ceda@latticeConfiguration@totalRows))
        for (n in 1: ceda@latticeConfiguration@totalCols){
          nCol = floor(runif(1,min = 1, max = ceda@latticeConfiguration@totalCols))  
          
          popMatrix <- data.frame(matrix(nrow=popLength, ncol=indSize))
          fit <- array(dim = popLength)
          
          #For each neigborhood
          for(n in 1:points){
            #Obtain the cell
            nRow <- nRow + neighborhood@yradio[n]
            if(nRow == 0 || ((nRow)%%ceda@latticeConfiguration@totalRows)==0){
              nRow <- nRow - 1
            }
            
            
            nCol<- nCol + neighborhood@xradio[n]
            if(nCol == 0 || ((nCol)%%ceda@latticeConfiguration@totalCols)==0){
              nCol <- nCol - 1
            }
            
            
            cell <- ((nRow)%%ceda@latticeConfiguration@totalRows) * ((nCol)%%ceda@latticeConfiguration@totalCols)  

            for(cn in 0:(sizeCell-1)){
              j<-1
              while(j <= indSize){
                popMatrix[m,j]=totalpopulation@populationmatrix[(cell+cn),j]
                j<-j+1
              }
              fit[m]=totalpopulation@fitness[(cell+cn)]
              m<-m+1
            }
            
          }
          
          #Run EDA
          population <- new("Population",populationmatrix= data.frame(popMatrix), fitness=array(fit))
          
          #Select 
          
          selPop <- selection(ceda@selectionOperator,population);
          selPop@populationmatrix <- check(selPop);
          dfPop <- convert.factor(selPop@populationmatrix);
          
          #Learning
          learning <- learning(ceda@learningOperator, dfPop);
          sampMatrix <- sampling(ceda@samplingOperator,learning,selPop@populationmatrix);
          
          #Evaluate
          fitness <- evaluate(ceda@evaluateOperator,convert.numeric(sampMatrix));
          
          if(ceda@samplingOperator@elitism==0){
            newMatrixPop=sampMatrix;
            newFitness=fitness; 
          }else{
            newMatrixPop=data.frame(rbind(selPop@populationmatrix[(1):(ceda@samplingOperator@elitism),],sampMatrix),row.names = NULL,check.names=TRUE,stringsAsFactors = FALSE );
            newFitness=c(selPop@fitness[1:ceda@samplingOperator@elitism],fitness)
          }
          
          #generate the new points (Size of cell)
          index <- order(newFitness, decreasing = TRUE);
          
          cell <- ((nRow)%%ceda@latticeConfiguration@totalRows) * ((nCol)%%ceda@latticeConfiguration@totalCols)  
          for(cn in 0:(sizeCell-1)){
            j<-1
            while(j <= indSize){
             totalpopulation@populationmatrix[(cell+cn),j] = newMatrixPop[index[cn+1],j]
              j<-j+1
            }
            totalpopulation@fitness[(cell+cn)] = newFitness[index[cn+1]]
          }
        }
      }
      statistics(totalpopulation,iter); 
    }
    }
    else{
      #Global Strategy Learning
      #Explorate the Grid Syncroned
      for (nRow in 1: ceda@latticeConfiguration@totalRows){
        if(!syncrone)
        {
          nRow = floor(runif(1,min = 1, max = ceda@latticeConfiguration@totalRows))
        }
        
        for (nCol in 1: ceda@latticeConfiguration@totalCols){
        
        if(!syncrone){
          nCol = floor(runif(1,min = 1, max = ceda@latticeConfiguration@totalCols))  
        }
          
          #Run EDA
          #Select 
          selPop <- selection(ceda@selectionOperator,totalpopulation);
          selPop@populationmatrix <- check(selPop);
          dfPop <- convert.factor(selPop@populationmatrix);
          
          #Learning
          learning <- learning(ceda@learningOperator, dfPop);
          sampMatrix <- sampling(ceda@samplingOperator,learning,selPop@populationmatrix);
          
          #Evaluate
          fitness <- evaluate(ceda@evaluateOperator,convert.numeric(sampMatrix));
          
          if(ceda@samplingOperator@elitism==0){
            newMatrixPop=sampMatrix;
            newFitness=fitness; 
          }else{
            newMatrixPop=data.frame(rbind(selPop@populationmatrix[(1):(ceda@samplingOperator@elitism),],sampMatrix),row.names = NULL,check.names=TRUE,stringsAsFactors = FALSE );
            newFitness=c(selPop@fitness[1:ceda@samplingOperator@elitism],fitness)
          }
          
          #generate the new points (Size of cell)
          index <- order(newFitness, decreasing = TRUE);
          
          cell <- ((nRow)%%ceda@latticeConfiguration@totalRows) * ((nCol)%%ceda@latticeConfiguration@totalCols)  
          for(cn in 0:(sizeCell-1)){
            j<-1
            while(j <= indSize){
              totalpopulation@populationmatrix[(cell+cn),j] = newMatrixPop[index[cn+1],j]
              j<-j+1
            }
            totalpopulation@fitness[(cell+cn)] = newFitness[index[cn+1]]
          }
        }
      }
      statistics(totalpopulation,iter); 
    }
  }
}