library(foreign) # load foreign package (converts data files into R)
library(survey)  # load survey package (analyzes complex design surveys)
library(ggplot2)
library(scales)


#import functions from current work directory
source("./functions.R")


#set the number of digits shown in all output
options( digits = 15 )


#set R to produce conservative standard errors instead of crashing
options(survey.lonely.psu = "adjust")


#import data set names and download them into .rda
#ONLY RUN ONCE. DO NOT RUN AGAIN ONCE .RDA FILE IS IN WORK DIRECTORY 
####################################
#source("./names_and_download.R")
####################################


#import prior nhanes data set names and download them into .rda
#ONLY RUN ONCE. DO NOT RUN AGAIN ONCE .RDA FILE IS IN WORK DIRECTORY 
####################################
#source("./download_prior_nhanes.R")
####################################


#-----------------------------------Load and create final data.frame for plotting
load("NHANES.rda") #original datasets
load("prior_NHANES.rda") #original prior nhanes datasets

#NHANES 2011-2012
A.demo <- NHANES.1112.Demo.df
A.glucose <- NHANES.1112.FastGlu.df
A.glucose <- exception_frame(A.glucose, "PHAFSTMN")
A.glucose <- exception_frame(A.glucose, "PHAFSTHR")
A.tri <- NHANES.1112.Trigly.df
A.gly <- NHANES.1112.Glycohemo.df
A.cad <- NHANES.1112.Cadmium.df
A.zinc <- NHANES.1112.Zinc.df
A.fq <- NHANES.1112.FastQuest.df
A.bm <- NHANES.1112.BM.df
A.bp <- NHANES.1112.BP.df
A.diq <- NHANES.1112.DIQ.df
A <- merge_frame(list(A.demo, A.glucose, A.tri, A.gly, A.cad, A.zinc, A.fq, A.bm, A.bp,
A.diq), c("SEQN"))
A <- extract_frame(A, c("SEQN", "LBDGLUSI", "LBDINSI", "LBDTRSI", "LBXGH", "LBDBCDSI", "PHAFSTMN", 
"PHAFSTHR", "BMXWT", "BMXHT", "BMXBMI", "BMXWAIST", "BPXSY3", "BPXDI3", "RIAGENDR", 
"RIDAGEYR", "RIDRETH1", "INDFMIN2", "INDFMPIR", "DID040", "DID060", "DIQ050",  "DIQ070", 
"DIQ160", "DIQ170", "LBDSZNSI", "RIDRETH3", "RIDEXAGY"))
A <- add_variable_frame(A, "YEAR", "11-12")

#NHANES 2009-2010
B.demo <- NHANES.0910.Demo.df
B.glucose <- NHANES.0910.FastGlu.df
B.glucose <- exception_frame(B.glucose, "PHAFSTMN")
B.glucose <- exception_frame(B.glucose, "PHAFSTHR")
B.tri <- NHANES.0910.Trigly.df
B.gly <- NHANES.0910.Glycohemo.df
B.cad <- NHANES.0910.Cadmium.df
B.fq <- NHANES.0910.FastQuest.df
B.bm <- NHANES.0910.BM.df
B.bp <- NHANES.0910.BP.df
B.diq <- NHANES.0910.DIQ.df
B <- merge_frame(list(B.demo, B.glucose, B.tri, B.gly, B.cad, B.fq, B.bm, B.bp,
B.diq), c("SEQN"))
B <- extract_frame(B, c("SEQN", "LBDGLUSI", "LBDINSI", "LBDTRSI", "LBXGH", "LBDBCDSI", "PHAFSTMN",
"PHAFSTHR", "BMXWT", "BMXHT", "BMXBMI", "BMXWAIST", "BPXSY3", "BPXDI3", "RIAGENDR", 
"RIDAGEYR", "RIDRETH1", "INDFMIN2", "INDFMPIR", "DID040", "DID060", "DIQ050", "DIQ070",
"DIQ160", "DIQ170"))
B <- add_variable_frame(B, "LBDSZNSI", NA)
B <- add_variable_frame(B, "RIDRETH3", NA)
B <- add_variable_frame(B, "RIDEXAGY", NA)
B <- add_variable_frame(B, "YEAR", "09-10")
colnames(B) <- colnames(A)

#NHANES 2007-2008
C.demo <- NHANES.0708.Demo.df
C.glucose <- NHANES.0708.FastGlu.df
C.glucose <- exception_frame(C.glucose, "PHAFSTMN")
C.glucose <- exception_frame(C.glucose, "PHAFSTHR")
C.tri <- NHANES.0708.Trigly.df
C.gly <- NHANES.0708.Glycohemo.df
C.cad <- NHANES.0708.Cadmium.df
C.fq <- NHANES.0708.FastQuest.df
C.bm <- NHANES.0708.BM.df
C.bp <- NHANES.0708.BP.df
C.diq <- NHANES.0708.DIQ.df
C <- merge_frame(list(C.demo, C.glucose, C.tri, C.gly, C.cad, C.fq, C.bm, C.bp,
C.diq), c("SEQN"))
C <- extract_frame(C, c("SEQN", "LBDGLUSI", "LBDINSI", "LBDTRSI", "LBXGH", "LBDBCDSI", "PHAFSTMN", 
"PHAFSTHR", "BMXWT", "BMXHT", "BMXBMI", "BMXWAIST", "BPXSY3", "BPXDI3", "RIAGENDR", 
"RIDAGEYR", "RIDRETH1", "INDFMIN2", "INDFMPIR", "DID040", "DID060", "DIQ050", "DID070",
"DIQ160", "DIQ170"))
C <- add_variable_frame(C, "LBDSZNSI", NA)
C <- add_variable_frame(C, "RIDRETH3", NA)
C <- add_variable_frame(C, "RIDEXAGY", NA)
C <- add_variable_frame(C, "YEAR", "07-08")
colnames(C) <- colnames(A)

#NHANES 2005-2006
D.demo <- NHANES.0506.Demo.df
D.glucose <- NHANES.0506.FastGlu.df
D.glucose <- exception_frame(D.glucose, "PHAFSTMN")
D.glucose <- exception_frame(D.glucose, "PHAFSTHR")
D.tri <- NHANES.0506.Trigly.df
D.gly <- NHANES.0506.Glycohemo.df
D.cad <- NHANES.0506.Cadmium.df
D.fq <- NHANES.0506.FastQuest.df
D.bm <- NHANES.0506.BM.df
D.bp <- NHANES.0506.BP.df
D.diq <- NHANES.0506.DIQ.df
D <- merge_frame(list(D.demo, D.glucose, D.tri, D.gly, D.cad, D.fq, D.bm, D.bp,
D.diq), c("SEQN"))
D <- extract_frame(D, c("SEQN", "LBDGLUSI", "LBDINSI", "LBDTRSI", "LBXGH", "LBDBCDSI", "PHAFSTMN", 
"PHAFSTHR", "BMXWT", "BMXHT", "BMXBMI", "BMXWAIST", "BPXSY3", "BPXDI3", "RIAGENDR", 
"RIDAGEYR", "RIDRETH1", "INDFMINC", "INDFMPIR", "DID040", "DID060", "DIQ050", "DID070", 
"DIQ160", "DIQ170"))
D <- add_variable_frame(D, "LBDSZNSI", NA)
D <- add_variable_frame(D, "RIDRETH3", NA)
D <- add_variable_frame(D, "RIDEXAGY", NA)
D <- add_variable_frame(D, "YEAR", "05-06")
colnames(D) <- colnames(A)

#NHANES 2003-2004
E.demo <- NHANES.0304.Demo.df
E.glucose <- NHANES.0304.FastGlu.df
E.tri <- NHANES.0304.Trigly.df
E.gly <- NHANES.0304.Glycohemo.df
E.cad <- NHANES.0304.Cadmium.df
E.fq <- NHANES.0304.FastQuest.df
E.bm <- NHANES.0304.BM.df
E.bp <- NHANES.0304.BP.df
E.diq <- NHANES.0304.DIQ.df
E <- merge_frame(list(E.demo, E.glucose, E.tri, E.gly, E.cad, E.fq, E.bm, E.bp,
E.diq), c("SEQN"))
E <- extract_frame(E, c("SEQN", "LBDGLUSI", "LBDINSI", "LBDTRSI", "LBXGH", "LBDBCDSI", "PHAFSTMN", 
"PHAFSTHR", "BMXWT", "BMXHT", "BMXBMI", "BMXWAIST", "BPXSY3", "BPXDI3", "RIAGENDR", 
"RIDAGEYR", "RIDRETH1", "INDFMINC", "INDFMPIR", "DID040G", "DID060G", "DIQ050", "DIQ070"))
E <- add_variable_frame(E, "DIQ160", NA)
E <- add_variable_frame(E, "DIQ170", NA)
E <- add_variable_frame(E, "LBDSZNSI", NA)
E <- add_variable_frame(E, "RIDRETH3", NA)
E <- add_variable_frame(E, "RIDEXAGY", NA)
E <- add_variable_frame(E, "YEAR", "03-04")
colnames(E) <- colnames(A)

#NHANES 2001-2002
F.demo <- NHANES.0102.Demo.df
F.glucose <- NHANES.0102.FastGlu.df
F.tri <- NHANES.0102.Trigly.df
F.gly <- NHANES.0102.Glycohemo.df
F.cad <- NHANES.0102.Cadmium.df
F.fq <- NHANES.0102.FastQuest.df
F.bm <- NHANES.0102.BM.df
F.bp <- NHANES.0102.BP.df
F.diq <- NHANES.0102.DIQ.df
F <- merge_frame(list(F.demo, F.glucose, F.tri, F.gly, F.cad, F.fq, F.bm, F.bp,
F.diq), c("SEQN"))
F <- extract_frame(F, c("SEQN", "LBXGLUSI", "LBXINSI", "LBDTRSI", "LBXGH", "LBDBCDSI", "PHAFSTMN", 
"PHAFSTHR", "BMXWT", "BMXHT", "BMXBMI", "BMXWAIST", "BPXSY3", "BPXDI3", "RIAGENDR", 
"RIDAGEYR", "RIDRETH1", "INDFMINC", "INDFMPIR", "DID040G", "DID060G", "DIQ050", "DIQ070"))
F <- add_variable_frame(F, "DIQ160", NA)
F <- add_variable_frame(F, "DIQ170", NA)
F <- add_variable_frame(F, "LBDSZNSI", NA)
F <- add_variable_frame(F, "RIDRETH3", NA)
F <- add_variable_frame(F, "RIDEXAGY", NA)
F <- add_variable_frame(F, "YEAR", "01-02")
colnames(F) <- colnames(A)

#NHANES 1999-2000
G.demo <- NHANES.9900.Demo.df
G.glucose <- NHANES.9900.FastGlu.df
G.tri <- NHANES.9900.Trigly.df
G.gly <- NHANES.9900.Glycohemo.df
G.cad <- NHANES.9900.Cadmium.df
G.fq <- NHANES.9900.FastQuest.df
G.bm <- NHANES.9900.BM.df
G.bp <- NHANES.9900.BP.df
G.diq <- NHANES.9900.DIQ.df
G <- merge_frame(list(G.demo, G.glucose, G.tri, G.gly, G.cad, G.fq, G.bm, G.bp,
G.diq), c("SEQN"))
G <- extract_frame(G, c("SEQN", "LBXGLUSI", "LBXINSI", "LBDTRSI", "LBXGH", "LBDBCDSI", "PHAFSTMN", 
"PHAFSTHR", "BMXWT", "BMXHT", "BMXBMI", "BMXWAIST", "BPXSY3", "BPXDI3", "RIAGENDR", 
"RIDAGEYR", "RIDRETH1", "INDFMINC", "INDFMPIR", "DIQ040G", "DIQ060G", "DIQ050", "DIQ070"))
G <- add_variable_frame(G, "DIQ160", NA)
G <- add_variable_frame(G, "DIQ170", NA)
G <- add_variable_frame(G, "LBDSZNSI", NA)
G <- add_variable_frame(G, "RIDRETH3", NA)
G <- add_variable_frame(G, "RIDEXAGY", NA)
G <- add_variable_frame(G, "YEAR", "99-00")
colnames(G) <- colnames(A)

#NHANES III 1988-1994
H.lab <- NHANESIII.Lab.df
H.exam <- NHANESIII.Exam.df
H.adult <- NHANESIII.Adult.df

#NHANES II 1976-1980
I.hema <- NHANESII.Hema.df
I.anthro <- NHANESII.Anthro.df
I.phys <- NHANESII.Phys.df
I.quest <- NHANESII.Quest.df

#NHANES I 1971-1974
J.phys <- NHANESI.Phys.df
J.med <- NHANESI.Med.df
J.health <- NHANESI.Health.df

#NHES I 1959-1962
K.demo <- NHESI.Demo.df
K.diab <- NHESI.Diab.df
K.phys <- NHESI.Phys.df
K.card <- NHESI.Card.df

#Stack all data.frames on top of each other
final <- rbind(A, B, C, D, E, F, G)

#split each variable of interest by YEAR for IGOR
IGOR_final <- IGOR_frame(final)


#-----------------------------------Plot cumulative fasting blood glucose by YEAR
ggplot(final, aes(sample=final$LBDGLUSI, color=YEAR)) + 
stat_qq(x=sample) +
ylab(expression(paste('Serum Glucose mM'))) + 
xlab('Standard Deviation or Z Score') +
ggtitle('NHANES Fasting Blood Glucose') +
coord_flip() +
scale_y_log10()
