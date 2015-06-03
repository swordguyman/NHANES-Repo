library(foreign) # load foreign package (converts data files into R)
library(survey)  # load survey package (analyzes complex design surveys)
library(scales)


#import functions from current work directory
source("./functions.R")


#set the number of digits shown in all output
options( digits = 15 )


#set R to produce conservative standard errors instead of crashing
options(survey.lonely.psu = "adjust")


#import data set names and download them into .rda
#ONLY RUN ONCE. DO NOT RUN AGAIN ONCE .RDA FILE IS IN WORK DIRECTORY 
source("./names_and_download.R")


#-----------------------------------Load and create final data.frame for plotting
load("NHANES.rda") #original datasets

#NHANES 2011-2012
A.glucose <- NHANES.1112.FastGlu.df
A <- extract_frame(A.glucose, c("SEQN", "LBDGLUSI"))
colnames(A)[2] <- "LBXGLUSI_11_12"
A <- add_variable_frame(A, "LBXGLUSI_09_10", NA)
A <- add_variable_frame(A, "LBXGLUSI_07_08", NA)
A <- add_variable_frame(A, "LBXGLUSI_05_06", NA)
A <- add_variable_frame(A, "LBXGLUSI_03_04", NA)
A <- add_variable_frame(A, "LBXGLUSI_01_02", NA)
A <- add_variable_frame(A, "LBXGLUSI_99_00", NA)

#NHANES 2009-2010
B.glucose <- NHANES.0910.FastGlu.df
B <- extract_frame(B.glucose, c("SEQN", "LBDGLUSI"))
colnames(B)[2] <- "LBXGLUSI_09_10"
dummy_B <- B[1]
dummy_B <- add_variable_frame(dummy_B, "LBXGLUSI_11_12", NA)
B <- cbind(dummy_B, B[2])
B <- add_variable_frame(B, "LBXGLUSI_07_08", NA)
B <- add_variable_frame(B, "LBXGLUSI_05_06", NA)
B <- add_variable_frame(B, "LBXGLUSI_03_04", NA)
B <- add_variable_frame(B, "LBXGLUSI_01_02", NA)
B <- add_variable_frame(B, "LBXGLUSI_99_00", NA)

#NHANES 2007-2008
C.glucose <- NHANES.0708.FastGlu.df
C <- extract_frame(C.glucose, c("SEQN", "LBDGLUSI"))
colnames(C)[2] <- "LBXGLUSI_07_08"
dummy_C <- C[1]
dummy_C <- add_variable_frame(dummy_C, "LBXGLUSI_11_12", NA)
dummy_C <- add_variable_frame(dummy_C, "LBXGLUSI_09_10", NA)
C <- cbind(dummy_C, C[2])
C <- add_variable_frame(C, "LBXGLUSI_05_06", NA)
C <- add_variable_frame(C, "LBXGLUSI_03_04", NA)
C <- add_variable_frame(C, "LBXGLUSI_01_02", NA)
C <- add_variable_frame(C, "LBXGLUSI_99_00", NA)

#NHANES 2005-2006
D.glucose <- NHANES.0506.FastGlu.df
D <- extract_frame(D.glucose, c("SEQN", "LBDGLUSI"))
colnames(D)[2] <- "LBXGLUSI_05_06"
dummy_D <- D[1]
dummy_D <- add_variable_frame(dummy_D, "LBXGLUSI_11_12", NA)
dummy_D <- add_variable_frame(dummy_D, "LBXGLUSI_09_10", NA)
dummy_D <- add_variable_frame(dummy_D, "LBXGLUSI_07_08", NA)
D <- cbind(dummy_D, D[2])
D <- add_variable_frame(D, "LBXGLUSI_03_04", NA)
D <- add_variable_frame(D, "LBXGLUSI_01_02", NA)
D <- add_variable_frame(D, "LBXGLUSI_99_00", NA)

#NHANES 2003-2004
E.glucose <- NHANES.0304.FastGlu.df
E <- extract_frame(E.glucose, c("SEQN", "LBDGLUSI"))
colnames(E)[2] <- "LBXGLUSI_03_04"
dummy_E <- E[1]
dummy_E <- add_variable_frame(dummy_E, "LBXGLUSI_11_12", NA)
dummy_E <- add_variable_frame(dummy_E, "LBXGLUSI_09_10", NA)
dummy_E <- add_variable_frame(dummy_E, "LBXGLUSI_07_08", NA)
dummy_E <- add_variable_frame(dummy_E, "LBXGLUSI_05_06", NA)
E <- cbind(dummy_E, E[2])
E <- add_variable_frame(E, "LBXGLUSI_01_02", NA)
E <- add_variable_frame(E, "LBXGLUSI_99_00", NA)

#NHANES 2001-2002
F.glucose <- NHANES.0102.FastGlu.df
F <- extract_frame(F.glucose, c("SEQN", "LBXGLUSI"))
colnames(F)[2] <- "LBXGLUSI_01_02"
dummy_F <- F[1]
dummy_F <- add_variable_frame(dummy_F, "LBXGLUSI_11_12", NA)
dummy_F <- add_variable_frame(dummy_F, "LBXGLUSI_09_10", NA)
dummy_F <- add_variable_frame(dummy_F, "LBXGLUSI_07_08", NA)
dummy_F <- add_variable_frame(dummy_F, "LBXGLUSI_05_06", NA)
dummy_F <- add_variable_frame(dummy_F, "LBXGLUSI_03_04", NA)
F <- cbind(dummy_F, F[2])
F <- add_variable_frame(F, "LBXGLUSI_99_00", NA)

#NHANES 1999-2000
G.glucose <- NHANES.9900.FastGlu.df
G <- extract_frame(G.glucose, c("SEQN", "LBXGLUSI"))
colnames(G)[2] <- "LBXGLUSI_99_00"
dummy_G <- G[1]
dummy_G <- add_variable_frame(dummy_G, "LBXGLUSI_11_12", NA)
dummy_G <- add_variable_frame(dummy_G, "LBXGLUSI_09_10", NA)
dummy_G <- add_variable_frame(dummy_G, "LBXGLUSI_07_08", NA)
dummy_G <- add_variable_frame(dummy_G, "LBXGLUSI_05_06", NA)
dummy_G <- add_variable_frame(dummy_G, "LBXGLUSI_03_04", NA)
dummy_G <- add_variable_frame(dummy_G, "LBXGLUSI_01_02", NA)
G <- cbind(dummy_G, G[2])

#Stack all data.frames on top of each other
final <- rbind(A, B, C, D, E, F, G)
