# source("init.all.R")
# init.all()

run <- function(fitFunction = "Ackley",indsize = 30,popSize = 500,select = 150,min=(-1),max=44,elitism=0,sample="RBN") {
  newEDA <- new("EDA")

	fitFun = new(fitFunction)
	init = "Continuous"
	popSize = popSize
	indSize = indsize
	selSize = select 
	varMin = c(rep(min,indsize))
	varMax = c(rep(max,indsize))
	elit = elitism
	select = "Truncation"
	learn <-new("RSMAX2",maximize = 'hc',restrict='iamb',test="cor",score="bic-g", debug= FALSE,optimized=TRUE)
	samp = sample
	stop <- new("Optimum",optimum=0,epsilon=0.000001,iterations=100)

  configure(newEDA,fitFun,init,popSize,indSize,selSize,elit,varMin,varMax,select,learn,samp,stop)
}

# for(i in 1:30){
#  run();
#  print(paste("FIN DE LA CORRIDA ",i))
# }
