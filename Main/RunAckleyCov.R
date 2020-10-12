# source("init.all.R")
# init.all()

run <- function(fitFunction = "Ackley",indsize = 10,popSize = 25,select = 7,min=(-1),max=44,elitism=1,sample="GaussianSHR") {
  newEDA <- new("EDA")

	fitFun = new(fitFunction)
	init = "Continuous"
	popSize = popSize
	indSize = indsize
	selSize = select 
	varMin = c(rep(min,indsize))
	varMax = c(rep(max,indsize))
	elit=elitism
	select = "Truncation"
	learn = new("COVSHRINK")
	samp = sample
	stop <- new("Optimum",optimum=0,epsilon=0.000001,iterations=100)

  configure(newEDA,fitFun,init,popSize,indSize,selSize,elit,varMin,varMax,select,learn,samp,stop)
}

# for(i in 1:1){
#  run();
#  print(paste("FIN DE LA CORRIDA ",i))
# }
