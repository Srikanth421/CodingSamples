# Creating a data frame
x <- 4:1
y <- -4:-1
q <- c("Hockey","Cricket","Football","Rugby")
theDF <- data.frame(x,y,q)
theDF <- data.frame(First=x,Second=y,Third=q)

#Investigating a Data Frame
head(theDF)
tail(theDF)
str(theDF)

#Attributes of data.frame
nrow(theDF)
ncol(theDF)
dim(theDF)
names(theDF)
names(theDF)[2]
rownames(theDF)
rownames(theDF) <- c("One","Two","Third","Fourth")
rownames(theDF) <- NULL
head(theDF,n=2)

#Selection of Data Frame Elements
theDF[3,2]
theDF[2,1:2]
theDF[2:4,2]
theDF[c(2,4),2]
theDF[c(2,4),2:3]
theDF[2:4,]
theDF[,c("First","Third")]
theDF[,"Third"]

#Selecting Data Frame Elements using Variable Names
theDF$Third
theDF$First

#Using Subset Function
subset(theDF,Third=="Hockey")
subset(theDF,First>3)
subset(theDF,select=First)

#Sorting
sort(theDF$Second, decreasing = TRUE)
sort(theDF$Third)
attach(theDF)
sort(Third)
detach(theDF)
sort(Third)

#Lists
list(1,2,3)
list(c(1,2,3))
list3 <- list(c(1,2,3),3:5)
list3
(list3 <- list(c(1,2,3),3:5))

#Selecting Elements for Lists
list(theDF,1:10)
names(list3)
names(list3) <- c("First","Second")
names(list3)
list3
(emptylist <- vector(mode="list",length=4))
list3[[1]]
list3[["First"]]
length(list3)
list3[[3]] <- 3:6
length(list3)
names(list3)
list3

# Matrix
matrix(1:9,byrow=TRUE,nrow=3)
matrix(1:9,byrow=FALSE,ncol=3)
newmatrix <- matrix(1:9,byrow=TRUE,nrow=3,
                    dimnames=list(c("First row","Second row","Third row"),
                                  c("First Col","Second Col","Third Col")))
newmatrix

# Naming the Rows and Columns
A <- matrix(1:10,nrow=5)
B <- matrix(21:30,nrow=5)
colnames(A)
rownames(A)
colnames(A) <- c("Left","Right")
rownames(A) <- c("1st","2nd","3rd","4th","5th")
colnames(A)
rownames(A)

# Sums of rows
rowSums(A)
colSums(A)

# Adding a column to a matrix
x <- c(11,12)
new_matrix <- rbind(A,x)
y <- c(13,14,15,16,17)
dim(y) <- c(5,1)
new_matrix2 <- cbind(A,y)

# Matrix Arithmetic
nrow(A)
ncol(A)
dim(A)
A+B
A*B
A == B
A %*% t(B)

# Arrays
theArray <- array(1:12,dim = c(2,3,2))
theArray[1,,]
theArray[1,,1]
theArray[,,1]
