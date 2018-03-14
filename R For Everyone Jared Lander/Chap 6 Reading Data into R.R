# Reading CSVs
theUrl <- "http://www.jaredlander.com/data/Tomato%20First.csv"
tomato <- read.table(file=theUrl,header=TRUE,sep=",")
head(tomato)

thePath <- "D:/Statistics Using R/R Course Slides/Tomato First.csv"
tomato1 <- read.table(file=thePath,header=TRUE,sep=",")
head(tomato1)

# Reading Excel data
#install.packages("XLConnect")
#getwd()
#setwd()
library("XLConnect")
tomatoXL <- readWorksheetFromFile("Tomato First.xlsx",sheet=1)
head(tomatoXL)

# Reading from Databases
# Install RODBC package
library(RODBC)
db <- odbcConnect("Facility Services")
employeeTable <- sqlQuery(db,"SELECT TOP 10 employee_number,last_name FROM employee_master")
employeeTable

# R Binary Files
save(tomato,file="D:/Statistics Using R/R Course Slides/tomato.rdata")
rm(tomato)
head(tomato)
load("D:/Statistics Using R/R Course Slides/tomato.rdata")
head(tomato)

# Data included with R
#install.packages("ggplot2")
require(ggplot2)
data()
data(diamonds)
head(diamonds)

# Extract Data From Web sites
# install.packages("XML")
require(XML)
theURL <- "http://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/"
bowlpool <- readHTMLTable(theURL, which=1,header=FALSE,stringsAsFactors=FALSE)
bowlpool
