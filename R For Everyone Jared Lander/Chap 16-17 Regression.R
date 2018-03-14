#Regression
require(UsingR)
head(father.son)
ggplot(father.son,aes(x=fheight,y=sheight))+geom_point()+
  geom_smooth(method="lm")+labs(x="Fathers",y="Sons")
heightsLM <- lm(sheight~fheight,data=father.son)
heightsLM
summary(heightsLM)
housing <- read.table("http://www.jaredlander.com/data/housing.csv",
                      sep=",",header=TRUE,
                      stringsAsFactors = FALSE)
names(housing)<-c("Neighborhood","Class","Units",
                  "YearBuilt","SqFt","Income",
                  "IncomePerSqFt","Expense",
                  "ExpensePerSqFt","NetIncome",
                  "Value","ValuePerSqFt","Boro")
head(housing)
ggplot(housing,aes(x=ValuePerSqFt))+
  geom_histogram(binwidth = 10)+labs(x="Value per Square Foot")

ggplot(housing,aes(x=ValuePerSqFt,fill=Boro))+
  geom_histogram(binwidth = 10)+labs(x="Value per Square Foot")

ggplot(housing,aes(x=ValuePerSqFt,fill=Boro))+
  geom_histogram(binwidth = 10)+labs(x="Value per Square Foot")+ facet_wrap(~Boro)

ggplot(housing,aes(x=SqFt))+geom_histogram()

ggplot(housing,aes(x=Units))+geom_histogram()

ggplot(housing[housing$Units<1000,],aes(x=SqFt))+geom_histogram()

ggplot(housing[housing$Units<1000,],
       aes(x=Units))+geom_histogram()

ggplot(housing,aes(x=SqFt,y=ValuePerSqFt))+geom_point()

ggplot(housing[housing$Units<1000,],aes(x=SqFt,y=ValuePerSqFt))+geom_point()

ggplot(housing,aes(x=Units,y=ValuePerSqFt))+geom_point()

ggplot(housing[housing$Units<1000,],aes(x=Units,y=ValuePerSqFt))+geom_point()

sum(housing$Units >=1000)

housing <- housing[housing$Units <1000,]

ggplot(housing,aes(x=log(SqFt),y=ValuePerSqFt)) +geom_point()

ggplot(housing,aes(x=log(Units),y=ValuePerSqFt))+geom_point()

house1<-lm(ValuePerSqFt~Units+SqFt+Boro,data=housing)
summary(house1)

house1$coefficients

coef(house1)

coefficients(house1)

require(coefplot)
coefplot(house1)

house2 <- lm(ValuePerSqFt~Units*SqFt+Boro,data=housing)
house3 <- lm(ValuePerSqFt~Units:SqFt+Boro,data=housing)
summary(house2)
summary(house3)
house2$coefficients
house3$coefficients

coefplot(house2)
coefplot(house3)

multiplot(house1,house2,house3)

housingNew <- read.table("http://www.jaredlander.com/data/housingNew.csv",sep=",",header=TRUE,
                         stringsAsFactors = FALSE)

housePredict <- predict(house1,newdata=housingNew,
                        se.fit=TRUE,interval="prediction",
                        level=.95)

head(housePredict$fit)

head(housePredict$se.fit)

#Logistic Regression

acs <- read.table("http://jaredlander.com/data/acs_ny.csv",sep=",",
                  header=TRUE,stringsAsFactors = FALSE)

acs$Income <- with(acs,FamilyIncome>=150000)

require(useful)


ggplot(acs,aes(x=FamilyIncome))+
  geom_density(fill="grey",color="grey")+
  geom_vline(xintercept=150000)+
  scale_x_continuous(label=multiple.dollar,limits=
                       c(0,1000000))

income1 <- glm(Income~HouseCosts+NumWorkers+OwnRent+
                 NumBedrooms+FamilyType,
               data=acs,family=binomial(link="logit"))
summary(income1)

invlogit <- function(x)
{
  1/(1+exp(-x))
}
invlogit(income1$coefficients)


