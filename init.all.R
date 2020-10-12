init.all <- function() {
	library(bnlearn);
	library(corpcor);
#	library(cec2005benchmark);
	
	source("Functions/ConfigureEDA.R")
	source("Functions/InitiationFunction.R")
	source("Functions/SelectionFunction.R");
	source("Functions/FitnessFunction.R");
	source("Functions/LearningFunction.R");
	source("Functions/SamplingFunction.R");
	source("Functions/StatisticFunction.R");
	source("Functions/StopFunction.R");
	source("Functions/EvaluateFunction.R");
	source("Functions/ExecuteEDA.R");
  #Cellular EDA
  source("Functions/ConfigurecEDA.R");
  source("Functions/GridFunction.R");
  source("Functions/ExecutecEDA.R");
  
	source("Utilities/convert.population.R");
	source("Utilities/preproses.regression.R");
	source("Utilities/f3Poly.R");
	source("Utilities/f5Poly.R");
	source("Utilities/f5Muhl.R");
	source("Utilities/oneEdge.R");
	#source("Utilities/f5Cuban1.R");
	#source("Utilities/f5Cuban2.R");
	#source("Utilities/fc4.R");
	#source("Utilities/fc5.R");

	source("Class/SelectionClass.R");
	source("Class/InitiationClass.R")
	source("Class/PopulationClass.R");
	source("Class/SamplingClass.R");
	source("Class/LearningClass.R");
	source("Class/EvaluateClass.R");
	source("Class/FitnessClass.R");
	source("Class/EDAClass.R");
	source("Class/SamplingClass.R");
	source("Class/StopClass.R");
  #Cellular EDA
  source("Class/LatticeConfigurationClass.R");
  source("Class/NeighbordhoodClass.R");
  source("Class/CellClass.R");
  source("Class/GridClass.R");
  source("Class/cEDAClass.R");
}

