setClass("SelectionOperator",representation(selSize="numeric"))

setClass("Truncation",contains = "SelectionOperator")
setClass("Random",contains = "SelectionOperator")
#setClass("Tournament",contains = "SelectionOperator")	
 


setMethod("selection","SelectionOperator",selection.default);
setMethod("selection","Truncation",selection.Truncation);
setMethod("selection","Random",selection.Random);