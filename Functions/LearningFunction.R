learning <- function(object,popMatrix) UseMethod("learning")

learning.LearningOperator<- function(object,popMatrix) "Learning default"


learning.COVSHRINK<- function(object,popMatrix) {	
   covshr <- cov.shrink(x = popMatrix, verbose = FALSE);
   covshr;
}

#Constraint Based Algorithms

learning.GS<- function(object,popMatrix) {
	
	dfPop <- convert.factor(popMatrix);

	learnedBN <- gs(x = dfPop,optimized = object@optimized);
	
	learnedBN;
}

learning.IAMB<- function(object,popMatrix) {
	
	dfPop <- convert.factor(popMatrix);

	learnedBN <- iamb(x = dfPop,optimized = object@optimized);
	
	learnedBN;
}

learning.FASTIAMB<- function(object,popMatrix) {
	
	dfPop <- convert.factor(popMatrix);

	learnedBN <- fast.iamb(x = dfPop,optimized = object@optimized);
	
	learnedBN;
}

learning.INTERIAMB<- function(object,popMatrix) {
	
	dfPop <- convert.factor(popMatrix);

	learnedBN <- inter.iamb(x = dfPop,optimized = object@optimized);
	
	learnedBN;
}

#Score Based Algorithms

learning.HC<- function(object,popMatrix) {
	
	dfPop <- convert.factor(popMatrix);

	learnedBN <- hc(x = dfPop,optimized = object@optimized);
	
	learnedBN;
}

learning.TABU<- function(object,popMatrix) {
	
	dfPop <- convert.factor(popMatrix);

	learnedBN <- tabu(x = dfPop,optimized = object@optimized);
	
	learnedBN;
}

#Hybrid Algorithms

learning.MMHC<- function(object,popMatrix) {
	
	dfPop <- convert.factor(popMatrix);

	learnedBN <- mmhc(x = dfPop, test = object@test, score = object@score, optimized = object@optimized);
	
	learnedBN;
}

learning.RSMAX2<- function(object, popMatrix) {
  learnedBN <- rsmax2(x = popMatrix, maximize = object@maximize, restrict = object@restrict, test=object@test, score=object@score,optimized = object@optimized,debug = object@debug);
	
	learnedBN;
}

#Constraint based local discovery

learning.MMPC<- function(object,popMatrix) {
	
	dfPop <- convert.factor(popMatrix);

	learnedBN <- mmpc(x = dfPop,optimized=object@optimized);
	
	learnedBN;
}

learning.ARACNE<- function(object,popMatrix) {
	
	dfPop <- convert.factor(popMatrix);

	learnedBN <- aracne(x = dfPop);
	
	learnedBN;
}

learning.CHOWLIU<- function(object,popMatrix) {
	
	dfPop <- convert.factor(popMatrix);

	learnedBN <- chow.liu(x = dfPop);
	
	learnedBN;
}