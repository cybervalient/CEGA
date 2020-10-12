setClass("EvaluateOperator",representation(fitnessFunction="Fitness"))

setMethod("evaluate","EvaluateOperator",evaluate.EvaluateOperator)

