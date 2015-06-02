#-----------------------------------Download and importation function
download.nhanes.file <- function( ftp.filepath ){ 
	# create a temporary file for downloading file to the local drive
	tf <- tempfile()
	
	# download the file using the ftp.filepath specified
	download.file( 
		# download the file stored in the location designated above
		ftp.filepath ,
		# save the file as the temporary file assigned above
		tf , 
		# download this as a binary file type
		mode = "wb"
	)
		
	# the variable 'tf' now contains the full file path 
	# on the local computer to the specified file
		
	read.xport( tf )	# the last line of a function contains what it *returns*
				# so by putting read.xport as the final line,
				# this function will return an r data frame
}



#-----------------------------------Deselect a column function
exception_frame <- function(frame, except){
	return(frame[,!(colnames(frame) == except)])
}



#-----------------------------------Variable extracter function
extract_frame <- function(frame, vector){
	return(frame[,vector])
}



#-----------------------------------Data merger function
merge_frame <- function(list_of_frames, merge_variable){
	new_frame <- Reduce(function(x,y) merge(x,y,by=merge_variable, all=TRUE), 
	list_of_frames)
	
	return(new_frame)
}



#-----------------------------------Add new column function
add_variable_frame <- function(frame, variable, value){
	N <- ncol(frame)
	new_frame <- frame
	new_frame[,N+1] <- value
	colnames(new_frame)[N+1] <- variable

	return(new_frame)	
}
