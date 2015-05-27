library(foreign) # load foreign package (converts data files into R)
library(survey)  # load survey package (analyzes complex design surveys)
library(ggplot2)
library(scales)

# set the number of digits shown in all output
options( digits = 15 )

# set R to produce conservative standard errors instead of crashing
options( survey.lonely.psu = "adjust" )



#for glucose
#-----------------------------------Set names for file locations
NHANES.1112.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2011-2012/GLU_G.xpt"	

NHANES.0910.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2009-2010/GLU_F.xpt"

NHANES.0708.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2007-2008/GLU_E.xpt"

NHANES.0506.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2005-2006/GLU_D.xpt"

NHANES.0304.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2003-2004/L10AM_C.xpt"

NHANES.0102.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2001-2002/L10AM_B.xpt"

NHANES.9900.FastGluc.file.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/1999-2000/LAB10AM.xpt"


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



#-----------------------------------Download files and save files in .rda
NHANES.1112.FastGlu.df <-
download.nhanes.file(NHANES.1112.FastGluc.file.location)

NHANES.0910.FastGlu.df <-
download.nhanes.file(NHANES.0910.FastGluc.file.location)

NHANES.0708.FastGlu.df <-
download.nhanes.file(NHANES.0708.FastGluc.file.location)

NHANES.0506.FastGlu.df <-
download.nhanes.file(NHANES.0506.FastGluc.file.location)

NHANES.0304.FastGlu.df <-
download.nhanes.file(NHANES.0304.FastGluc.file.location)

NHANES.0102.FastGlu.df <-
download.nhanes.file(NHANES.0102.FastGluc.file.location)

NHANES.9900.FastGlu.df <-
download.nhanes.file(NHANES.9900.FastGluc.file.location)


save(
	NHANES.1112.FastGlu.df,
	NHANES.0910.FastGlu.df,
	NHANES.0708.FastGlu.df,
	NHANES.0506.FastGlu.df,
	NHANES.0304.FastGlu.df,
	NHANES.0102.FastGlu.df,
	NHANES.9900.FastGlu.df,
	file = "NHANES.FastGlu.rda" 
)



#-----------------------------------Load and create final data.frame for plotting
load( "NHANES.FastGlu.rda" )

#original datasets intact
x1112 <- NHANES.1112.FastGlu.df
x0910 <- NHANES.0910.FastGlu.df
x0708 <- NHANES.0708.FastGlu.df
x0506 <- NHANES.0506.FastGlu.df
x0304 <- NHANES.0304.FastGlu.df
x0102 <- NHANES.0102.FastGlu.df
x9900 <- NHANES.0102.FastGlu.df

#Get only SEQN and LBDGLUSI(LBXGLUSI for 99-02)
x1112 <- x1112[,c('SEQN', 'LBDGLUSI')]
x0910 <- x0910[,c('SEQN', 'LBDGLUSI')]
x0708 <- x0708[,c('SEQN', 'LBDGLUSI')]
x0506 <- x0506[,c('SEQN', 'LBDGLUSI')]
x0304 <- x0304[,c('SEQN', 'LBDGLUSI')]
x0102 <- x0102[,c('SEQN', 'LBXGLUSI')]
x9900 <- x9900[,c('SEQN', 'LBXGLUSI')]

#Rename to 'LBDGLUSI' (only 99-02)
colnames(x0102)[2] <- 'LBDGLUSI'
colnames(x9900)[2] <- 'LBDGLUSI'

#Add extra column for year
x1112[,3] <- '11-12'
x0910[,3] <- '09-10'
x0708[,3] <- '07-08'
x0506[,3] <- '05-06'
x0304[,3] <- '03-04'
x0102[,3] <- '01-02'
x9900[,3] <- '99-00'

#Name the varaible YEAR
colnames(x1112)[3] <- 'YEAR'
colnames(x0910)[3] <- 'YEAR'
colnames(x0708)[3] <- 'YEAR'
colnames(x0506)[3] <- 'YEAR'
colnames(x0304)[3] <- 'YEAR'
colnames(x0102)[3] <- 'YEAR'
colnames(x9900)[3] <- 'YEAR'

#Stack all data.frames on top of each other
final <- rbind(x1112, x0910, x0708, x0506, x0304, x0102, x9900)

#-----------------------------------Plot cumulative fasting blood glucose by YEAR
ggplot(final, aes(x=final$LBDGLUSI, color=YEAR)) + 
geom_point(aes(y=..y..),stat="ecdf") +
xlab(expression(paste('Serum Glucose mM'))) + 
ylab('Fraction of the Population') +
ggtitle('NHANES Fasting Blood Glucose') + 
coord_trans(x = 'log10')