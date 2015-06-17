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



#-----------------------------------Split YEAR variable string by '-' and replace with '_'
split_YEAR <- function(vector){
	new_vector <- vector()

	for(i in 1:length(vector)){
		splitted <- strsplit(vector[i], '-')
		new_vector[i] <- paste(splitted[[1]][1], '_', splitted[[1]][2], sep='')
	}
	
	return(new_vector)
}



#-----------------------------------Split final data frame's variables by year for IGOR
IGOR_frame <- function(frame){
	#initialize data.frame with SEQN column
	new_frame <- data.frame(SEQN=frame$SEQN)

	#split elements
	splits <- unique(frame$YEAR)

	#number of times to split each variable
	split_number <- length(splits)
	
	#get name vector for each split; back portion of new variable name
	new_names <- split_YEAR(splits)

	#total number of variables
	total <- length(colnames(final))

	#variable SEQN, column 1, does not need to be split
	#variable YEAR, last column, does not need to be split
	for(i in 2:(total-1)){
		#initialize indices
		start <- 0
		end <- 0

		for(j in 1:split_number){
			#new column index
			new_index <- (j+1)+((i-2)*split_number)

			#initialize NA column
			new_frame[,new_index] <- rep(NA, nrow(frame))

			#name new column
			old_var_name <- colnames(frame)[i]
			colnames(new_frame)[new_index] <- 
			paste(old_var_name, '_',  new_names[j], sep='')

			#update indices
			start <- 1 + end
			end <- end + sum(frame$YEAR == splits[j])

			#update frame variable info to new column
			new_frame[start:end, new_index] <- frame[start:end, i]
		}
	}

	return(new_frame)
}
