source("init.all.R")
init.all()
run <- function(fitFunction = "F3Poly",indsize = 30,popSize = 100,select = 50,min=0,max=1,elitism=1,optimum=10.47) {
  newEDA <- new("EDA")

	fitFun=new(fitFunction)
  init="Discrete"
	popSize= popSize
	indSize=indsize
	selSize= select
	elit=elitism
	varMin= c(rep(min,indsize))
	varMax= c(rep(max,indsize))
	select= "Truncation"
	learn <-new("MMHC",optimized=TRUE, test="mi-sh", score="bic")
	samp <- "RBN"
  stop <- new("Found", found=optimum, iterations=20)
  configure(newEDA,fitFun,init,popSize,indSize,selSize,elit,varMin,varMax,select,learn,samp,stop)
}
#for(i in 1:30){
# run();
# print(paste("FIN DE LA CORRIDA ",i))
#}