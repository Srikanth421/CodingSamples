# paste
paste("Hello","Jared","and Srikanth")
paste("Hello","Jared","and Srikanth",sep="/")
paste(c("Hello","Jared"),c("Hello","Srikanth"))
paste("Hello",c("Jared","Srikanth"))
vectorOfText <- c("Hello","Everyone","Out there",".")
paste(vectorOfText,collapse=" ")
paste(vectorOfText,collapse="*")

#sprintf
person <- "Srikanth"
partSize <- "eight"
waitTime <- 25
sprintf("Hello %s, your party of %s will be seated 
        in %s minutes",person,partSize,waitTime)
sprintf("Hello %s, your party of %s will be seated 
        in %s minutes",c("Jared","Bob"),
        c("eight",16,"four",10),waitTime)

# Extracting Text
require(XML)
theURL <- "http://www.loc.gov/rr/print/list/057_chron.html"
presidents <- readHTMLTable(theURL,which=3,as.data.frame = TRUE,
                            skip.rows = 1,header=TRUE,
                            stringsAsFactors=FALSE)
head(presidents)
tail(presidents)

require(stringr)

yearList <- str_split(string = presidents$YEAR,pattern="-")
head(yearList)
yearMatrix <- data.frame(Reduce(rbind,yearList))
head(yearMatrix)
names(yearMatrix) <- c("Start","Stop")
presidents <- cbind(presidents,yearMatrix)
presidents$Start <- as.numeric(as.character(presidents$Start))
presidents$Stop <- as.numeric(as.character(presidents$Stop))
head(presidents)
tail(presidents)

# Get the first 3 characters
str_sub(string = presidents$PRESIDENT,start=1,end=3)
# Get the 5th thru 9th characters
str_sub(string = presidents$PRESIDENT,start=5,end=9)

presidents[str_sub(string=presidents$Start,start=4,
                   end=4)==1,c("YEAR","PRESIDENT","Start","Stop")]

# Regular Expressions

johnPos <- str_detect(string = presidents$PRESIDENT,pattern="John")
presidents[johnPos,c("YEAR","PRESIDENT","Start","Stop")]
badsearch <- str_detect(string = presidents$PRESIDENT,pattern="John")
goodsearch <- str_detect(string = presidents$PRESIDENT,pattern=ignore.case("John"))
sum(badsearch)
sum(goodsearch)
presidents <- presidents[1:64,]
goodsearch <- str_detect(string = presidents$PRESIDENT,pattern=ignore.case("John"))
sum(goodsearch)

# Loading rdata files
con <- url("http://www.jaredlander.com/data/warTimes.rdata")
load(con)
close(con)
head(warTimes,10)
warTimes[str_detect(string=warTimes,pattern = "-")]
theTimes <- str_split(string=warTimes,pattern="(ACAEA)|-",n=2)
head(theTimes)
which(str_detect(string=warTimes,pattern = "-"))
theTimes[[147]]
theTimes[[150]]
theStart <- sapply(theTimes,FUN=function(x) x[1])
head(theStart)
str_extract(string=theStart,pattern = "January")
theStart[str_detect(string=theStart,pattern = "January")]
head(str_extract(string=theStart,"[0-9]{4}"),20)
head(str_extract(string=theStart,"\\d{4}"),20)
head(str_extract(string=theStart,"^\\d{4}"),30)
head(str_extract(string=theStart,"\\d{4}$"),20)
head(str_replace(string=theStart,pattern="\\d",replacement="x"),30)
