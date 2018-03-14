# if and else
check.bool <- function(x)
{
    if (x==1)
  {
      print("hello")
  } else
  {
      print("goodbye")
  }
}
check.bool(1)
check.bool(0)
check.bool(TRUE)

# if and else if
check.bool <- function(x)
{
  if (x==1)
  {
    print("hello")
  } else if (x == 0)
  {
    print("goodbye")
  } else
  {
      print("confused")
  }
}
check.bool(1)
check.bool(0)
check.bool(2)
check.bool("we")

# switch()
use.switch <- function(x)
{
  switch(x, "a"="First","b"="Second","z"="Last",
         "c"="Third","Other")
}

#ifelse
ifelse(1==1,"Yes","No")
toTest <- c(1,1,0,1,0,1)
ifelse(toTest==1,"Yes","No")
ifelse(toTest==1,toTest*3,toTest)
toTest[2] <- NA
ifelse(toTest==1,"Yes","No")

#Compound Tests
a <- c(1,1,1)
b <- c(0,1,0)
ifelse(a==1 & b==1, "Yes", "No")
ifelse(a==1 && b==1, "Yes", "No")
