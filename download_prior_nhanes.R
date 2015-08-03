#NHESI (1959-1962) (Ages 18-79) VARIABLES
#-----------------------------------
NHESI.Demo.location <- 
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhes123/DU1001"
NHESI.Diab.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhes123/DU1007"


#-----------------------------------Download files and save files in .rda
NHESI.Demo.df <- download.prior.nhanes(NHESI.Demo.location)
NHESI.Diab.df <- download.prior.nhanes(NHESI.Diabetes.location)


#saves file in current work directory
save(
	NHESI.Demo.df,
	NHESI.Diab.df,

	file = 'prior_NHANES.rda'
)