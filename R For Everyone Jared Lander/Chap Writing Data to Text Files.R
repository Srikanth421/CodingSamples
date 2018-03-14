mydata <- data.frame(x1=c(1,2,3,4),
                     x2=c(0.1,0.2,0.3,0.5),
                     x3=c(0.01,0.03,0.05,0.09))
mydata

# Basic write command
write.table(mydata,file="data/write.datatest.txt",
            row.names = FALSE,col.names = FALSE,sep=", ")

# Variants of write.table()
write.csv(mydata,file="data/write.datatest.csv")
write.csv2(mydata,file="data/write.datatest2.csv")

# Other writing functions
cat("Test file for cat\n",round(rnorm(9),2),
    file="data/cattest.txt")
lin <- c("Count down",paste(rev(1:10),collapse="-"),"Go")
writeLines(lin,con = "data/writelinestest.txt")

# Direct output to external file
sink("data/sinktest.txt")
x <- 1:5
y <- 1:4
outer(x,y)
sink()

# Save assignments
x <- 3:10
y <- rpois(10,3) # Poisson distribution
dump(c("x","y"),file="data/dumptest.txt")
source(file="data/dumptest.txt")

# save r objects
lis <- list(x=1:4,y=5,z=c("a","b"))
dput(lis,file="data/dputtest.txt")
dget(file="data/dputtest.txt")

# Using file connection
f2 <- file("data/testout.txt",open="w")
cat("Header of file\n\n",file=f2)
mat<-matrix(round(rnorm(12),8),ncol=3)
write.table(mat,file=f2,row.names = FALSE,col.names = FALSE)
close(f2)

# append option
cat("Header of file\n\n",file="data/testappend.txt")
mat<-matrix(round(rnorm(12),8),ncol=3)
write.table(mat,file="data/testappend.txt",row.names = FALSE,col.names = FALSE,append=TRUE)
