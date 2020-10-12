createGrid<- function(lattice, population) UseMethod("createGrid")

createGrid.Grid <- function(lattice, population){
  #Create the grid
  cells <- matrix(lattice@totalRows,lattice@totalCols);
  countPob<-1;
  for( i in 1: lattice@totalRows){
    for( j in 1: lattice@totalCols){
      initsubpobM <- matrix(lattice@totalRowsPerCell*lattice@totalColsPerCell, indSize);
      fitsubpob <- array(totalRowsPerCell*lattice@totalColsPerCell);
      for(k in 1:lattice@totalRowsPerCell*lattice@totalColsPerCell){
        initsubpobM[k,]<-population@populationmatrix[countPob];
        fitsubpob[k]<-population@fitness[countPob];
        countPob <- countPob + 1;
      }
      
      cells[i,j] <- new("Cell", as.data.frame(initsubpobM), fitsubpob); 
    }
  }
  return(cells);
}