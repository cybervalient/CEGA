setClass("SamplingOperator",representation(
			sampleSize="numeric",
			varmin="numeric",
			varmax="numeric",
			elitism="numeric"))

setClass("Gaussian",contains="SamplingOperator")
setClass("GaussianSHR",contains="SamplingOperator")
setClass("RBN",contains="SamplingOperator")
setMethod("sampling","Gaussian",sampling.Gaussian)
setMethod("sampling","GaussianSHR",sampling.GaussianSHR)

setMethod("sampling","RBN",sampling.RBN)