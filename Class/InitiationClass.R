setClass("InitiationOperator",representation(
	populationSize="numeric", 
	individualSize="numeric",	
	variableMinimum="numeric",
	variableMaximum="numeric"
))


setClass("Discrete",contains = "InitiationOperator")
setClass("Continuous",contains = "InitiationOperator")


setMethod("initiation","Discrete",initiation.Discrete)
setMethod("initiation","Continuous",initiation.Continuous)
