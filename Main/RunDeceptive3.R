# source("init.all.R")
# init.all()

run <- function(fitFunction = "Deceptive3",indsize = 30,popSize = 200,select = 100,min=0,max=1,elitism=1,optimum=10) {
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
	learn <-new("RSMAX2",maximize = 'hc',restrict='fast.iamb', test="mi-sh", score="bic", debug= FALSE ,optimized=TRUE)
	samp <- "RBN"
  stop <- new("Found",found=optimum,iterations=30)
  configure(newEDA,fitFun,init,popSize,indSize,selSize,elit,varMin,varMax,select,learn,samp,stop)

}

# for(i in 1:30){
#  run();
#  print(paste("FIN DE LA CORRIDA ",i))
# }