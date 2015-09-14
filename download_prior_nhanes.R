#NHESI (1959-1962) (Ages 18-79) VARIABLES
#-----------------------------------
NHESI.Demo.location <- 
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhes123/DU1001"
NHESI.Diab.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhes123/DU1007"
NHESI.Phys.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhes123/DU1003"
NHESI.Card.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhes123/DU1004"


#NHESII (1963-1965) (Ages 6-11) VARIABLES
#-----------------------------------
NHESII.All.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhes123/DU2idt"


#NHESIII (1966-1970) (Ages 12-17) VARIABLES
#-----------------------------------
NHESIII.All.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhes123/DU3edt"


#NHANES I (1971-1974) (Ages 1-74) VARIABLES
#-----------------------------------
NHANESI.Phys.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhanesi/DU4111"
NHANESI.Med.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhanesi/DU4233"
NHANESI.Health.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhanesi/DU4091"


#NHANES II (1976-1980) (Ages 1-74) VARIABLES
#-----------------------------------
NHANESII.Hema.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhanesii/DU5411"
NHANESII.Anthro.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhanesii/DU5301"
NHANESII.Phys.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhanesii/DU5302"
NHANESII.Quest.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhanesii/DU5020"


#Hispanic HANES (1982-1984) (Ages 1-74) VARIABLES
#-----------------------------------
HHANES.Dia.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/hhanes/DU6506"
HHANES.Body.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/hhanes/DU6501"
HHANES.Quest.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/hhanes/DU6521"


#NHANES III (1988-1994) (Ages 2 months and older) VARIABLES
#-----------------------------------
NHANESIII.Lab.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhanes3/1A/lab"
NHANESIII.Exam.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhanes3/1A/exam"
NHANESIII.Adult.location <-
"ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/nhanes3/1A/adult"


#-----------------------------------Download files and save files in .rda
NHESI.Demo.df <- download.prior.nhanes(NHESI.Demo.location)
NHESI.Diab.df <- download.prior.nhanes(NHESI.Diab.location)
NHESI.Phys.df <- download.prior.nhanes(NHESI.Phys.location)
NHESI.Card.df <- download.prior.nhanes(NHESI.Card.location)
NHESII.All.df <- download.prior.nhanes(NHESII.All.location)
NHESIII.All.df <- download.prior.nhanes(NHESII.All.location)
NHANESI.Phys.df <- download.prior.nhanes(NHANESI.Phys.location)
NHANESI.Med.df <- download.prior.nhanes(NHANESI.Med.location)
NHANESI.Health.df <- download.prior.nhanes(NHANESI.Health.location)
NHANESII.Hema.df <- download.prior.nhanes(NHANESII.Hema.location)
NHANESII.Anthro.df <- download.prior.nhanes(NHANESII.Anthro.location)
NHANESII.Phys.df <- download.prior.nhanes(NHANESII.Phys.location)
NHANESII.Quest.df <- download.prior.nhanes(NHANESII.Quest.location)
HHANES.Dia.df <- download.prior.nhanes(HHANES.Dia.location)
HHANES.Body.df <- download.prior.nhanes(HHANES.Body.location)
HHANES.Quest.df <- download.prior.nhanes(HHANES.Quest.location)
NHANESIII.Lab.df <- download.prior.nhanes(NHANESIII.Lab.location, TRUE)
NHANESIII.Exam.df <- download.prior.nhanes(NHANESIII.Exam.location, TRUE)
NHANESIII.Adult.df <- download.prior.nhanes(NHANESIII.Adult.location, TRUE)


#saves file in current work directory
save(
	NHESI.Demo.df,
	NHESI.Diab.df,
	NHESI.Phys.df,
	NHESI.Card.df,
	NHESII.All.df,
	NHESIII.All.df,
	NHANESI.Phys.df,
	NHANESI.Med.df,
	NHANESI.Health.df,
	NHANESII.Hema.df,
	NHANESII.Anthro.df,
	NHANESII.Phys.df,
	NHANESII.Quest.df,
	HHANES.Dia.df,
	HHANES.Body.df,
	HHANES.Quest.df,
	NHANESIII.Lab.df,
	NHANESIII.Exam.df,
	NHANESIII.Adult.df,

	file = 'prior_NHANES.rda'
)