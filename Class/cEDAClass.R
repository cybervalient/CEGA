setClass("cEDA",representation(
  initiationOperator="InitiationOperator",
  selectionOperator="SelectionOperator",
  learningOperator="LearningOperator",
  samplingOperator="SamplingOperator",
  evaluateOperator="EvaluateOperator",
  stopCondition="StopCondition",
  neighborhood="Neighborhood",
  latticeConfiguration="LatticeConfiguration"))

setClass("cEDAContinuous",contains="cEDA")
setClass("cEDADiscrete",contains="cEDA")

setMethod("config","cEDA",config.cEDA)
setMethod("executeSync","cEDA",executeSync.cEDA)
setMethod("executeSync","cEDAContinuous",executeSync.cEDAContinuous)
setMethod("executeSync","cEDADiscrete",executeSync.cEDADiscrete)
