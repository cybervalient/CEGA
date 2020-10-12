#setClass("StopCondition",representation(population="Population",iterations="numeric"))
setClass("StopCondition",representation(iterations="numeric"))


setClass("Optimum",representation(optimum="numeric",epsilon="numeric"),contains="StopCondition")
setClass("Found",representation(found="numeric"),contains="StopCondition")
setClass("Eq",contains="StopCondition")
setClass("Range",representation(alpha="numeric"),contains="StopCondition")
setClass("Mean",representation(delta="numeric",
					 invocCount="numeric",
					 prevMean="numeric",
				       lastCount="numeric"),contains="StopCondition")
setClass("Target",representation(target="array"),contains="StopCondition")

setMethod("stop","StopCondition",stop.StopCondition)
setMethod("stop","Optimum",stop.Optimum)
setMethod("stop","Found",stop.Found)
setMethod("stop","Eq",stop.Eq)
setMethod("stop","Range",stop.Range)
setMethod("stop","Mean",stop.Mean)
setMethod("stop","Target",stop.Target)




