# Probability Distributions
rnorm(n=10)
rnorm(n=10,mean=100,sd=20)
randNorm10 <- rnorm(10)
randNorm10
dnorm(randNorm10)
dnorm(c(-1,0,1))
randNorm <- rnorm(30000)
randDensity <- dnorm(randNorm)
ggplot(data.frame(x=randNorm,y=randDensity))+
  aes(x=x,y=y)+geom_point()+
  labs(x="Random Normal Variables",y="Density")
###################################################
pnorm(randNorm10)
pnorm(c(-3,0,3))
pnorm(2)-pnorm(-2)
p <- ggplot(data.frame(x=randNorm,y=randDensity))+
  aes(x=x,y=y)+geom_line()+labs(x="x",y="Density")
neg1Pos1Seq <- seq(from=-1,to=1,by=.1)
neg1To1 <- data.frame(x=neg1Pos1Seq,y=dnorm(neg1Pos1Seq))
head(neg1To1)
neg1To1 <- rbind(c(min(neg1To1$x),0),
                 neg1To1,
                 c(max(neg1To1$x),0))
p+geom_polygon(data=neg1To1,aes(x=x,y=y))
randProb <- pnorm(randNorm)
ggplot(data.frame(x=randNorm,y=randProb))+aes(x=x,y=y)+
  geom_point()+labs(x="Random Normal Variables",y="Probability")
randNorm10
qnorm(pnorm(randNorm10))
all.equal(randNorm10,qnorm(pnorm(randNorm10)))
# Basic Statistics
x <- sample(x=1:100,size=100,replace=TRUE)
x
mean(x)
y <- x
y[sample(x=1:100,size=20,replace=FALSE)]<- NA
y
mean(y)
mean(y,na.rm=TRUE)
grades <- c(95,72,87,66)
weights <- c(1/2,1/4,1/8,1/8)
mean(grades)
weighted.mean(x=grades,w=weights)
var(x)
sum((x-mean(x))^2)/(length(x)-1)
sqrt(var(x))
sd(x)
sd(y)
sd(y,na.rm=TRUE)
min(x)
max(x)
median(x)
min(y)
min(y,na.rm=TRUE)
summary(x)
summary(y)
quantile(x,probs=c(0.25,0.75))
quantile(y,probs=c(0.25,0.75))
quantile(y,probs=c(0.25,0.75),na.rm=TRUE)
quantile(x,probs=c(0.1,0.25,0.5,0.75,0.99))
#Correlation
head(economics)
cor(economics$pce,economics$psavert)
xPart <- economics$pce-mean(economics$pce)
yPart <- economics$psavert-mean(economics$psavert)
nMinusOne <- (nrow(economics)-1)
xSD <- sd(economics$pce)
ySD <- sd(economics$psavert)
sum(xPart*yPart)/(nMinusOne*xSD*ySD)
cor(economics[,c(2,4:6)])
#install.packages("GGally")
#install.packages("scales")
#install.packages("colorspace")
GGally::ggpairs(economics[,c(2,4:6)],upper="blank")
econCor <- cor(economics[,c(2,4:6)])
econMelt <- melt(econCor,varnames=c("x","y"),
                 value.name="Correlation")
econMelt <- econMelt[order(econMelt$Correlation),]
econMelt
ggplot(econMelt,aes(x=x,y=y))+
  geom_tile(aes(fill=Correlation))+
  scale_fill_gradient2(low=muted("red"),mid="white",
                       high="steelblue",
                       guide=guide_colorbar(ticks=FALSE,barheight=10),
                       limits=c(-1,1))+
  theme_minimal()+
  labs(x=NULL,y=NULL)

# Correlation - Missing data
m <- c(9,9,NA,3,NA,5,8,1,10,4)
n <- c(2,NA,1,6,6,4,1,1,6,7)
p <- c(8,4,3,9,10,NA,3,NA,9,9)
q <- c(10,10,7,8,4,2,8,5,5,2)
r <- c(1,9,7,6,5,6,2,7,9,10)
theMat <- cbind(m,n,p,q,r)
cor(theMat,use="everything")
cor(theMat,use="all.obs")
cor(theMat,use="complete.obs")
cor(theMat,use="na.or.complete")
cor(theMat[c(1,4,7,9,10),])
identical(cor(theMat,use="complete.obs"),
          cor(theMat[c(1,4,7,9,10),]))
data(tips,package="reshape2")
head(tips)
GGally::ggpairs(tips)

# Comic
require(RXKCD)
getXKCD(which="552")

# Covariance
cov(economics$pce,economics$psavert)
cov(economics[,c(2,4:6)])
identical(cov(economics$pce,economics$psavert),
          cor(economics$pce,economics$psavert)*
            sd(economics$pce)*sd(economics$psavert))

# T-tests
head(tips)
unique(tips$sex)
unique(tips$day)

# One-sample t-test

t.test(tips$tip,alternative="two.sided",mu=2.5)

# Build a t distribution
randT <- rt(30000,df=NROW(tips)-1)
tipTTest <- t.test(tips$tip,alternative = "two.sided",mu=2.50)
ggplot(data.frame(x=randT))+
  geom_density(aes(x=x),fill="grey",color="grey")+
  geom_vline(xintercept = tipTTest$statistic)+
  geom_vline(xintercept = mean(randT)+c(-2,2)*sd(randT),linetype=2)

# One-sided

t.test(tips$tip,alternative = "greater",mu=2.5)

# Two- Sample t-test

aggregate(tip~sex,data=tips,var)
shapiro.test(tips$tip)
ggplot(tips,aes(x=tip,fill=sex))+
  geom_histogram(binwidth=.5,alpha=1/2)

ansari.test(tip~sex,tips)
t.test(tip~sex,data=tips,var.equal=TRUE)

# Paired two-sample t-test
head(father.son)
t.test(father.son$fheight,father.son$sheight,paired = TRUE)
heightDiff <- father.son$fheight - father.son$sheight
ggplot(father.son,aes(x=fheight-sheight))+
  geom_density()+
  geom_vline(xintercept=mean(heightDiff))+
  geom_vline(xintercept=mean(heightDiff)+ 2*c(-1,1)*sd(heightDiff)/sqrt(nrow(father.son)),
             linetype=2)


#ANOVA
tipAnova <- aov(tip~day-1,tips)
tipIntercept <- aov(tip~day,tips)
tipAnova$coefficients
tipIntercept$coefficients
summary(tipAnova)
require(plyr)
tipsByDay <- ddply(tips,"day",summarize,
                   tip.mean=mean(tip),tip.sd=sd(tip),
                   Length=NROW(tip),
                   tfrac=qt(p=.90,df=Length-1),
                   Lower=tip.mean-tfrac*tip.sd/sqrt(Length),
                   Upper=tip.mean+tfrac*tip.sd/sqrt(Length))
require(ggplot2)
ggplot(tipsByDay,aes(x=tip.mean,y=day))+geom_point()+
  geom_errorbarh(aes(xmin=Lower,xmax=Upper),height=.3)











