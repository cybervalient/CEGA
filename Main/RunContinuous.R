source("D:\\REDA\\init.all.R")
init.all()
print("run(fitFunction,indsize,popSize,select,min,max,elitism,samp)")
run <- function(fitFunction = "Ackley",indsize = 10,popSize = 25,select = 7,min=(-1),max=44,elitism=0,sample="GaussianSHR") {

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
	stop <- new("Optimum",optimum=0,epsilon=0.000001,iterations=200)

configure(newEDA,fitFun,init,popSize,indSize,selSize,elit,varMin,varMax,select,learn,samp,stop)
print("run(fitFunction,indsize,popSize,select,min,max,elitism,samp)")
}