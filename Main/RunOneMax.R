source("D:\\REDA\\init.all.R")
init.all()


run <- function(fitFunction = "OneMax",indsize = 50,popSize = 150,select = 45,min=0,max=1,elitism=1,optimum=50) {


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
	learn <-new("RSMAX2",maximize = 'hc',restrict='gs',debug= FALSE ,optimized=TRUE)
	samp <- "RBN"
     	stop <- new("Found",found=optimum,iterations=20)
      configure(newEDA,fitFun,init,popSize,indSize,selSize,elit,varMin,varMax,select,learn,samp,stop)

}
for(i in 1:30){
 run();
 print(paste("FIN DE LA CORRIDA ",i))
}