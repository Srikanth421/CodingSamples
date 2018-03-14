# Simple function
say.hello <- function()
{
  print("Hello, World!")
}
say.hello

# Function Arguments
sprintf("Hello %s", "Jared")
sprintf("Hello %s,today is %s","Jared","Sunday")
hello.person <- function(name)
{
  print(sprintf("Hello %s",name))
}
hello.person("Jared")
hello.person("Srikanth")

# By position
hello.person <- function(first,last)
{
  print(sprintf("Hello %s %s",first,last))
}

hello.person("Srikanth","Potukuchi")
hello.person(first="Harshed",last="Oke")
hello.person(first="Harshed","Oke")
hello.person(last="Oke",first="Harshed")
hello.person(l="Oke",fir="Harshed")

#Default Arguments
hello.person <- function(first,last="Reddy")
{
  print(sprintf("Hello %s %s",first,last))
}
hello.person("Jared")
hello.person("Ashwini")
hello.person("Ashwini","R")
hello.person("Jared",extra="Goodbye")
hello.person <- function(first,last="Doe",...)
{
  print(sprintf("Hello %s %s",first,last))
}
hello.person("Jared",extra="Goodbye")

# Return Values
double.num <- function(x)
{
  x+2
  x*2
}
double.num(5)
double.sum <- function(x)
{
  return(x+2)
  x*2
}
double.sum(5)

#do.call function
do.call("hello.person",args=list(first="Srikanth",last="Potukuchi"))

run.this <- function(x,func=mean)
{
  do.call(func,args=list(x))
}
run.this(1:10)
run.this(1:10,sum)
run.this(1:10,sd)
