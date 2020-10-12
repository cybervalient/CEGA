setClass("Population",representation(populationmatrix ="data.frame",fitness="array"))
setMethod("statistics","Population",statistics.Population)

