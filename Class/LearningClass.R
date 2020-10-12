setClass("LearningOperator",representation("logical"))

setClass("COVSHRINK",contains="LearningOperator")

setClass("GS",representation(optimized = "logical"),contains="LearningOperator")
setClass("IAMB",representation(optimized = "logical"),contains="LearningOperator")
setClass("FASTIAMB",representation(optimized = "logical"),contains="LearningOperator")
setClass("INTERIAMB",representation(optimized = "logical"),contains="LearningOperator")

setClass("HC",representation(optimized = "logical"),contains="LearningOperator")
setClass("TABU",representation(optimized = "logical"),contains="LearningOperator")

setClass("MMHC",representation(optimized = "logical", test = "character", score = "character"),contains="LearningOperator")
setClass("RSMAX2",representation(maximize = "character", restrict = "character",optimized = "logical", debug="logical", test = "character", score = "character"),contains="LearningOperator")

setMethod("learning","LearningOperator",learning.LearningOperator)

setMethod("learning","GS",learning.GS)
setMethod("learning","IAMB",learning.IAMB)
setMethod("learning","FASTIAMB",learning.FASTIAMB)
setMethod("learning","INTERIAMB",learning.INTERIAMB)

setMethod("learning","HC",learning.HC)
setMethod("learning","TABU",learning.TABU)

setMethod("learning","MMHC",learning.MMHC)
setMethod("learning","RSMAX2",learning.RSMAX2)

setMethod("learning","COVSHRINK",learning.COVSHRINK)


		