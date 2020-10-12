source("init.all.R")
init.all()
print("run(fitFunction,indsize,popSize,select,min,max,elitism,optimum)")

run <- function(fitFunction = "OneMax",indsize = 50,popSize = 100,select = 30,min=0,max=1,elitism=1,optimum=50) {
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
	learn <-new("RSMAX2",maximize = 'hc',restrict='gs',test='mi-sh', score='bic',debug= FALSE ,optimized=TRUE)
	samp <- "RBN"
  stop <- new("Found",found=optimum,iterations=30)


  configure(newEDA,fitFun,init,popSize,indSize,selSize,elit,varMin,varMax,select,learn,samp,stop)
  print("run(fitFunction,indsize,popSize,select,min,max,elitism,optimum)")
}