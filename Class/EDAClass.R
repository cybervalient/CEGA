setClass("EDA",representation(
		initiationOperator="InitiationOperator",
		selectionOperator="SelectionOperator",
		learningOperator="LearningOperator",
		samplingOperator="SamplingOperator",
		evaluateOperator="EvaluateOperator",
		stopCondition="StopCondition"))

setClass("EDAContinuous",contains="EDA")
setClass("EDADiscrete",contains="EDA")

setMethod("configure","EDA",configure.EDA)
setMethod("execute","EDA",execute.EDA)
setMethod("execute","EDAContinuous",execute.EDAContinuous)
setMethod("execute","EDADiscrete",execute.EDADiscrete)
