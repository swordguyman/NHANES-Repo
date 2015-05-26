options(java.parameters="-Xmx2g")
library(mclust)
library(xlsx)
file=file.choose()
file
data=read.csv(file, header=T)
ncols=ncol(data)
B=1000
BIC= AIC =LL=array(0,c(ncols,B,6))
minBIC=minAIC=maxLL= matrix(rep(0,ncols*B), nrow=ncols, ncol=B,byrow=T)
frac= array(0,c(ncols,B,10))
means=array(0,c(ncols,B,12))
stddevs= array(0,c(ncols,B,9))
lendata=rep(0,ncols)
pmt=(proc.time())
for (i  in 1:ncols) {
      dataset=data[,i]
      datasetcorrect=dataset[!is.na(dataset)]
      nobs=length(datasetcorrect)
      lendata[i]=nobs
      boots=rep(0,nobs)
      set.seed(1)
      for (b in 1:B) {
            j=sample(1:nobs,size=nobs,replace=TRUE)
            boots=datasetcorrect[j]
            lnboots=log(boots)
            LLoffsetln=-sum(lnboots)
            McN=Mclust(boots,G=1, prior=priorControl())
            BIC[i,b,1]=-McN$bic
            AIC[i,b,1]=2*2-2*McN$loglik
            LL[i,b,1]=McN$loglik
            means[i,b,1]= McN$ parameters$mean
            stddevs[i,b,1]= sqrt(McN$parameters$variance$sigmasq)
            
            McLN=Mclust(lnboots,G=1, prior=priorControl())
            BIC[i,b,2]=-McLN$bic-2*LLoffsetln
            AIC[i,b,2]=2*2-2*(McLN$loglik+LLoffsetln)
            LL[i,b,2]=McLN$loglik+LLoffsetln
            means[i,b,2]= McLN$ parameters$mean
            stddevs[i,b,2]= sqrt(McLN$parameters$variance$sigmasq)
            
            McE=Mclust(lnboots,G=2,modelNames="E", prior=priorControl())
            BIC[i,b,3]= -McE$bic-2* LLoffsetln 
            AIC[i,b,3]=2*4-2*(McE$loglik+LLoffsetln)
            LL[i,b,3]=McE$loglik+LLoffsetln
            frac[i,b,1:2]=McE$ parameters$pro
            means[i,b,3:4]= McE$ parameters$mean
            stddevs[i,b,3]=sqrt(McE$ parameters$ variance$sigmasq)
            
            McV=Mclust(lnboots,G=2,modelNames="V" ,prior=priorControl())
            BIC[i,b,4]= -McV$bic-2* LLoffsetln 
            AIC[i,b,4]=2*5-2*(McV$loglik+LLoffsetln)
            LL[i,b,4]=McV$loglik+LLoffsetln
            frac[i,b,3:4]=McV$ parameters$pro
            means[i,b,5:6]= McV$ parameters$mean
            stddevs[i,b,4:5]=sqrt(McV$ parameters$ variance$sigmasq)
            
            
            Mc3E=Mclust(lnboots,G=3,modelNames="E", prior=priorControl())
            BIC[i, b,5]= -Mc3E$bic-2* LLoffsetln 
            AIC[i,b,5]=2*6-2*(Mc3E$loglik+LLoffsetln)
            LL[i,b,5]=Mc3E$loglik+LLoffsetln
            frac[i,b,5:7]= Mc3E$ parameters$pro
            means[i,b,7:9]=Mc3E$ parameters$mean
            stddevs[i,b,6]=sqrt(Mc3E$ parameters$ variance$sigmasq)
            
            Mc3V = Mclust(lnboots,G=3,modelNames="V",prior=priorControl())
            BIC[i,b,6]= -Mc3V$bic-2*LLoffsetln
            AIC[i,b,6]=2*8-2*(Mc3V$loglik+LLoffsetln)
            LL[i,b,6]=Mc3V$loglik+LLoffsetln
            
            fx=Mc3V$ parameters$pro
            xbar=Mc3V$ parameters$mean
            SD=sqrt(Mc3V$ parameters$ variance$sigmasq)  
            
            o=order(fx,na.last=T,decreasing=T)
            
            mat=cbind(fx[o],xbar[o],SD[o])
            
            frac[i,b,8:10]=mat[,1]
            means[i,b,10:12]= mat[,2]
            stddevs[i,b,7:9]=mat[,3]  
            
            minBIC[i,b]=which.min(c(BIC[i,b,1],BIC[i,b,2],BIC[i,b,3], BIC[i,b,4],BIC[i,b,5],BIC[i,b,6]))
            minAIC[i,b]=which.min(c(AIC[i,b,1],AIC[i,b,2],AIC[i,b,3], AIC[i,b,4],AIC[i,b,5],AIC[i,b,6]))
            maxLL[i,b]=which.max(c(LL[i,b,1],LL[i,b,2],LL[i,b,3], LL[i,b,4],LL[i,b,5],LL[i,b,6]))        
      }
}

# BIC
# AIC
# LL
# frac
# means
# stddevs
# minBIC
# minAIC
# maxLL

counts=NULL
for (k in 1:ncols){
      print(names(data) [k])
      print(lendata[k])
      print(tabulate(minBIC[k,]))
      print(which.max(tabulate(minBIC[k,])))
      print(prop.table(table(minBIC[k,])))
      counts[k]=which.max(tabulate(minBIC[k,])) 
}

nBDcols = 62

cols<-c("BICN","BICLN","BIC2LNE","BIC2LNU","BIC3LNE","BIC3LNU","minBIC","SPACE1",
        "AICN","AICLN","AIC2LNE","AIC2LNU","AIC3LNE","AIC3LN3U","minAIC","SPACE2",
        "LLN","LLLN","LL2LNE","LL2LNU","LL3LNE","LL3LNU","maxLL","SPACE3" ,
        "meanN","stddevN","fracN","SPACE4" ,"meanLN","stddevLN","fracLN","SPACE5" ,
        "mean2LNE1","mean2LNE2","stddev2LNE","frac2LNE1","frac2LNE2","SPACE6", 
        "mean2LNU1","mean2LNU2","stddev2LNU1",  "stddev2LNU2",  "frac2LNU1","frac2LNU2","SPACE7",
        "mean3LNE1","mean3LNE2", "mean3LNE3","stddev3LNE","frac3LNE1","frac3LNE2","frac3LNE3", "SPACE8","mean3LNU1","mean3LNU2","mean3LNU3","stddev3LNU1",  "stddev3LNU2",  "stddev3LNU3",  "frac3LNU1","frac3LNU2","frac3LNU3")
BigDataboot=array(rep(NA, ncols*B*nBDcols),dim=c(ncols,B,nBDcols),dimnames=list(names(data), as.character(seq(1:B)),cols))
BigDataboot[,, 1:6] <- BIC
BigDataboot[,, 7] <- minBIC
BigDataboot[,, 9:14] <- AIC
BigDataboot[,, 15] <- minAIC
BigDataboot[,, 17:22] <- LL
BigDataboot[,, 23] <- maxLL

BigDataboot[,,c(25,29,33,34,39,40,46,47,48,54,55,56) ] <- means
BigDataboot[,,c(26,30,35,41,42,49,57,58,59) ] <- stddevs
BigDataboot[,,c(36,37,43,44,50,51,52,60,61,62) ] <- frac
BigDataboot[,,c(27,31)]=array(rep(1,2*ncols*B), dim=c(ncols,B,2))  # insert a one for fraction...??
BDbootfull <- createWorkbook(type="xlsx") 
for (i  in 1:ncols) {
      addDataFrame(BigDataboot[i,,], createSheet(BDbootfull, sheetName=names(data) [i]),col.names=TRUE)}
saveWorkbook(BDbootfull, "BigDatabootfull_output_HbA1c_1999b.xlsx")  
print(proc.time()-pmt)


