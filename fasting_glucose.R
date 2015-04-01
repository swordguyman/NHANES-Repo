library(foreign) # load foreign package (converts data files into R)
library(survey)  # load survey package (analyzes complex design surveys)
library(ggplot2)

# set the number of digits shown in all output
options( digits = 15 )

# set R to produce conservative standard errors instead of crashing
options( survey.lonely.psu = "adjust" )



#-----------------------------------Set names for file locations
NHANES.1112.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2011-2012/GLU_G.xpt"	

NHANES.0910.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2009-2010/GLU_F.xpt"

NHANES.0708.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2007-2008/GLU_E.xpt"

NHANES.0506.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2005-2006/GLU_D.xpt"



#-----------------------------------Download and importation function
download.and.import.any.nhanes.file <- function( ftp.filepath ){ 
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



#-----------------------------------Download files and save files in .rda
NHANES.1112.FastGlu.df <-
download.and.import.any.nhanes.file(NHANES.1112.FastGluc.file.location)

NHANES.0910.FastGlu.df <-
download.and.import.any.nhanes.file(NHANES.0910.FastGluc.file.location)

NHANES.0708.FastGlu.df <-
download.and.import.any.nhanes.file(NHANES.0708.FastGluc.file.location)

NHANES.0506.FastGlu.df <-
download.and.import.any.nhanes.file(NHANES.0506.FastGluc.file.location)

save(
	NHANES.1112.FastGlu.df,
	NHANES.0910.FastGlu.df,
	NHANES.0708.FastGlu.df,
	NHANES.0506.FastGlu.df,
	file = "NHANES.FastGlu.rda" 
)



#-----------------------------------Load and create final data.frame for plotting
load( "NHANES.FastGlu.rda" )

x1112 <- NHANES.1112.FastGlu.df
x0910 <- NHANES.0910.FastGlu.df
x0708 <- NHANES.0708.FastGlu.df
x0506 <- NHANES.0506.FastGlu.df

#Set up year variable for each data.frame
x1112[,9] <- '11-12'
x0910[,9] <- '09-10'
x0708[,9] <- '07-08'
x0506[,9] <- '05-06'

#Name the varaible YEAR
colnames(x1112)[9] <- 'YEAR'
colnames(x0910)[9] <- 'YEAR'
colnames(x0708)[9] <- 'YEAR'
colnames(x0506)[9] <- 'YEAR'

#Stack all data.frames on top of each other
final <- rbind(x1112, x0910, x0708, x0506)



#-----------------------------------Plot cumulative fasting blood glucose by YEAR
ggplot(final, aes(x=final$LBDGLUSI, color=YEAR)) + 
geom_point(aes(y=..y..),stat="ecdf") +
xlab(expression(paste('Serum Glucose ', mu, 'M'))) + 
ylab('Fraction of the Population') +
ggtitle('NHANES Fasting Blood Glucose') + 
scale_x_log10(breaks=c(5,10,15,20,25,30)) +
scale_y_continuous(breaks=c(.05, .1, .5, .9, .95))