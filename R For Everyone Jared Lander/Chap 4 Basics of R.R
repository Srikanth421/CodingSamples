# Arithmetic in R
1+1 
5*7
3/4
2^3
5%%2 # modulo
4*5+3-2/4+(2-3)^2 # pemdas

# Variable Assignment
x <- 5
x
y = 5
y
assign("z",5) # To know more about a function ?<name-of-the-function>
z
7 <- z # won't work
z <- 7
a <- b <- 7
a
b
rm(z) # remove variable
z

# Basic Data Types in R- Numeric and Character
class(x)
is.numeric(x)
i <- 5
i
is.integer(i)
i <- 5L
i
is.integer(i)
x<- "data"
x
y <- factor("data")
y
nchar(x)
nchar("hello")
nchar(5678)
nchar(y)

# Basic Data Types in R- Date
date1 <- as.Date("2016-06-28")
class(date1)
as.numeric(date1)
# The number of days since January 1, 1970
date2 <- as.POSIXct("2016-06-16 10:30")
date2
class(date2)
#seconds
as.numeric(date2)
class(date1)
class(as.numeric(date1))

#Basic Data Types in R- Logical
TRUE*10 # TRUE is same as 1
FALSE * -10
k <- TRUE
k
is.logical(k)
class(T) # shortcut for TRUE
T <- 10
T
# But can be overridden best not to use
TRUE <- 10

#Vectors in R
x <- c(1,4,7,10)
y <- c("R","SAS","Excel","SQL")
y
z <- c(TRUE,FALSE) # This is a boolean vector

# Naming the vector
c(one="a",two="b",last="c")
w <- 2:5
names(w) <- c("x1","x2","x3","x4")
w
# Vector Operations
x*3
x+4
x/5
x^3
sqrt(x)
# create two vectors of equal length
x <- 1:10
y <- -5:4
x+y
x-y
x*y
x/y
x^y
length(x)
length(y)
length(x+y)
x+c(1,1,2)
x
# SUm of Elements in a Vector
total_x <- sum(x)
total_x

#Making comparisons
x <=5
x>y
y
any(x<y)
all(x<y)

# Vector Selection
x[1]
x[4:7]
x[c(1,4)]
x

#Exercise
poker_vector <- c(140,-50,20,-120,240)
roulette_vector <- c(-24,-50,100,-350,10)
days_vector <- c("Monday","Tuesday","Wednesday","Thursday","Friday")
names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector
total_daily <- poker_vector+roulette_vector
total_poker <- sum(poker_vector)
total_roulette <- sum(roulette_vector)
total_week <- total_poker+total_roulette
poker_wednesday <- poker_vector[3]
# Selecting multiple elements in a Vector
poker_vector[c(1,5)]
poker_midweek <- poker_vector[c(2,3,4)]
poker_midweek
average_midweek_gain <- mean(poker_vector[c(2,3,4)])
selection_vector <- poker_vector>0
poker_winning_days <- poker_vector[c(1,3,5)]

# Creating Factors
q <- c("Hockey","Lacrosse","Water Polo")
q
q3 <- c(q,"Cricket","Hockey")
q3
q3factor <- as.factor(q3)
q3factor
as.numeric(q3factor)

# Types of Categorical Variables
animals_vector <- c("Elephant", "Giraffe", "Donkey", "Horse")
temperature_vector <- c("High", "Low", "High","Low", "Medium")
factor_animals_vector <- factor(animals_vector)
factor_animals_vector
factor_temperature_vector <- factor(temperature_vector, order = TRUE, levels = c("Low", "Medium", "High"))
factor_temperature_vector

# Ordered Factors
factor(x=c("High School","College","Masters"),ordered=TRUE)
factor(x=c("High School","College","Masters"),order=TRUE,
       levels=c("High School","College","Masters"))

#Exercise
survey_vector <- c("M","F","F","M","M")
factor_survey_vector <- factor(survey_vector)
levels(factor_survey_vector) <- c("Female","Male")

#Missing Data
z <- c(1,2,NA,8,3)
z
is.na(z)
length(z)
zchar <- c("Hockey",NA,"Lacrosse")
zchar
length(zchar)
zchar <- c("Hockey",NULL,"Lacrosse")
