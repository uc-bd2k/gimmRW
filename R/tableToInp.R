############################################################
## Name				: tabletoInp()
## Purpose		: This function takes the genes data table object
##							as input and produces a .inp file for processing
##							by "gimm".
## Parameters : 1. geneDataTable - Gene Data table object
##							2. fileName - fileName of the .inp file
##								 Extension will be pruned if provided  
## Author			: Vinayak Kumar
############################################################
tableToInp <-
function(geneDataTable, fileName, M) {

    ## if object doesn't exist in the current folder
    if (missing(geneDataTable)) {
        cat(" Data object not provided! .. Exiting tableToInp() function \n")
        return (geneDataTable)
    }
    ## means that file is in current folder
    else {
		
        ##Get the number of rows		
        noOfRows <- nrow(geneDataTable)
        noOfCols <- ncol(geneDataTable)
				
				## Check whether the no of columns are M + 2 or not
				if (noOfCols != (M + 2)) {
					cat(fileName, " No. of columns in the text file should be M + 2", 
            ".. Exiting tableToInp() function \n")
				  geneDataTable <- NA
					## Return NA as output which will provide info to upper level
					## funciton that something has gone wrong with this function.
					return (geneDataTable)
				}
 
        ## Retrives the filename without any extension	
        inpFileName <- getOnlyFileName(fileName)

        ## File connection is opened for writing
        inpFileName <- paste("./", inpFileName, ".inp", sep="")

        ## Write the data
        write.table(geneDataTable[ , c(-1,-2)],
                    inpFileName, sep="\t", dec=".",
                    row.names=FALSE, col.names=FALSE, quote=FALSE)
        ## Returns the Whole of the Table read from the txt file
        ## this object will be used for writing some data in .cdt file

  #      .GeneDataTable <<- geneDataTable

        return (geneDataTable)
     }
}

"tablePriorToInp" <-
function(geneDataTable, fileName, priorFileName, M) {

    ## if object doesn't exist in the current folder
    if (missing(geneDataTable)) {
        cat(" Data object not provided! .. Exiting tableToInp() function \n")
        return (geneDataTable)
    }
    ## means that file is in current folder
    else {
		
	#zhen
	txtPriorData<- read.table(priorFilename, header=TRUE)

        ## Get the number of rows		
        noOfRows <- nrow(geneDataTable)
        noOfCols <- ncol(geneDataTable)
				
				## Check whether the no of columns are M + 2 or not
				if (noOfCols != (M + 2)) {
					cat(fileName, " No. of columns in the text file should be M + 2", ".. Exiting tableToInp() function \n")
				  geneDataTable <- NA
					## Return NA as output which will provide info to upper level
					## funciton that something has gone wrong with this function.
					return (geneDataTable)
				}

				## Combine expression data and prior data together
				if(dim(txtPriorData)[1] != noOfRows)
				{
					combineTable<-geneDataTable[,c(-1,-2)]
					cat("Incorrect number of rows for prior information\n")
				}
				else
				{
					if(sum(txtGeneData[,1] != txtPriorData[,1]) > 0)
						cat("Expression data and prior data do not match\n")
					else
						combineTable<-cbind(geneDataTable[,c(-1,-2)],txtPriorData[,c(-1,-2)])
				}
 
        ## Retrives the filename without any extension	
        inpFileName <- getOnlyFileName(fileName)

        ## File connection is opened for writing
        inpFileName <- paste("./", inpFileName, ".inp", sep="")

        ## Write the data
        write.table(combineTable, inpFileName, sep="\t", dec=".",
                    row.names=FALSE, col.names=FALSE, quote=FALSE)
        ## Returns the Whole of the Table read from the txt file
        ## this object will be used for writing some data in .cdt file

#         .GeneDataTable <<- geneDataTable

        return (geneDataTable)
     }
}

