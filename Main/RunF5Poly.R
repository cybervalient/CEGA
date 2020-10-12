source("D:\\REDA\\init.all.R")
init.all()


run <- function(fitFunction = "F5Poly",indsize = 30,popSize =1000,select = 300,min=0,max=1,elitism=1,opt=10.338) {

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
	learn <-new("RSMAX2",maximize = 'hc',restrict='mmpc',debug= FALSE ,optimized=TRUE)
	samp <- "RBN"
     	stop <- new("Optimum",optimum=opt,epsilon=0.000001,iterations=20)
      configure(newEDA,fitFun,init,popSize,indSize,selSize,elit,varMin,varMax,select,learn,samp,stop)

}
for(i in 1:30){
 run();
 print(paste("FIN DE LA CORRIDA ",i))
}