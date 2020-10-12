source("init.all.R")
init.all()

run <- function(fitFunction = "OneMax",indsize = 1000,popSize = 100,select = 30,min=0,max=1,elitism=1,optimum=1000) {
  newcEDA <- new("cEDA")
  
  fitFun=new(fitFunction)
  init="Discrete"
  popSize= popSize
  indSize=indsize
  selSize= select
  elit=elitism
  varMin= c(rep(min,indsize))
  varMax= c(rep(max,indsize))
  select= "Truncation"
  learn <-new("RSMAX2",maximize = 'hc',restrict='gs',test='mi-sh', score='bic',debug= FALSE ,optimized=TRUE)
  samp <- "RBN"
  stop <- new("Found",found=optimum,iterations=40000)
  
  #Config the cellular EDA
  lattice<-new("LatticeConfiguration", totalRows=5, totalCols=5, totalRowsPerCell=2, 
                                                       totalColsPerCell=2)
  xradio <- array(c(0,0,0,-1,1))
  yradio <- array(c(0,-1,1,0,0))
  neighborhood<-new("Neighborhood", xradio = xradio,yradio = yradio)
  
  config(newcEDA,fitFun,init,lattice, neighborhood,indSize,selSize,elit,varMin,varMax,select,learn,samp, stop)
  print("run(fitFunction,indsize,popSize,select,min,max,elitism,optimum)")
}