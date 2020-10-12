setClass("Grid", representation(cells="data.frame", 
                                nRow="numeric", 
                                nCol="numeric",
                                nRowPerCell="numeric",
                                nColPerCell="numeric"))
setMethod("createGrid","Grid",createGrid.Grid)
#setMethod("getCell","Grid",getCell.Grid)