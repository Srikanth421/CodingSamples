# Apply Family

theMatrix <- matrix(1:9,nrow=3)
apply(theMatrix,1,sum)
apply(theMatrix,2,sum)

#lapply
theList <- list(A=matrix(1:9,3),B=1:5,C=matrix(1:4,2),D=2)
lapply(theList,sum)

#sapply
sapply(theList,sum)

#lapply and sapply can also take a vector as input
theNames <- c("Srikanth","Ashwini","Harshed")
lapply(theNames,nchar)
sapply(theNames,nchar)

#mapply
firstList <- list(A=matrix(1:16,4),B=matrix(1:16,2),D=1:5)
secondList <- list(A=matrix(1:16,4),B=matrix(1:16,8),C=15:1)

mapply(identical,firstList,secondList)

simplefunc <- function(x,y)
{
  NROW(x) + NROW(y)
}
mapply(simplefunc,firstList,secondList)

# aggregate function
require(ggplot2)
data(diamonds)
head(diamonds)
aggregate(price~cut,diamonds,mean)
aggregate(price~cut+color,diamonds,mean)

# aggregate two variables

aggregate(cbind(price,carat)~cut,diamonds,mean)

aggregate(cbind(price,carat)~cut+color,diamonds,mean)

# plyr package
require(plyr)
# ddply
head(baseball)
baseball$sf[baseball$year<1954]<-0
baseball$hbp[is.na(baseball$hbp)]<-0
baseball <- baseball[baseball$ab >= 50,]
baseball$OBP<-with(baseball,(h+bb+hbp)/(ab+bb+hbp+sf))
tail(baseball)

obp <- function(data)
{
  c(OBP=with(data,sum(h+bb+hbp)/sum(ab+bb+hbp+sf)))
}
careerOBP <- ddply(baseball,.variables="id",.fun=obp)
head(careerOBP)

# llply
llply(theList,sum)
identical(lapply(theList,sum),llply(theList,sum))

# plyr Helper Functions
aggregate(price~cut,diamonds,each(mean,median))

system.time(dlply(baseball,"id",nrow))

iBaseball <- idata.frame(baseball)

system.time(dlply(iBaseball,"id",nrow))

# data.table
# install.packages("data.table")
require(data.table)
theDF <- data.frame(A=1:10,
                    B=letters[1:10],
                    C=LETTERS[11:20],
                    D=rep(c("One","Two","Three"),length.out=10))
theDT <- data.table(A=1:10,
                    B=letters[1:10],
                    C=LETTERS[11:20],
                    D=rep(c("One","Two","Three"),length.out=10))


# Compare them
class(theDF$B)
class(theDT$B)

diamondsDT <- data.table(diamonds)
diamondsDT
diamondsDT[1:2,]
diamondsDT[diamonds$carat>=0.8,]
diamondsDT[,list(color)]

# show tables
tables()

# set the key
setkey(diamondsDT,color)
key(diamondsDT)
tables()

# data.table aggregation
diamondsDT[,mean(price),by=cut]
diamondsDT[,list(price=mean(price)),by=cut]
diamondsDT[,mean(price),by=list(cut,color)]
diamondsDT[,list(price=mean(price),carat=mean(carat),
           caratSum=sum(carat)),by=cut]
# Multiple metrics and multiple grouping
diamondsDT[,list(price=mean(price),carat=mean(carat)),
                 by=list(cut,color)]






