# for loops

for (i in 1:10)
{
  print(i)
}
print(1:10)

# catalogue function

head(mtcars)
d <- mtcars[,c(1,4)]
for (x in d)
{
  cat("Column Average:",mean(x),"\n")
}

# while loop

x <- 1
while (x <= 5)
{
  print(x)
  x <- x+1
}

# Controlling Loops

for (i in 1:10)
{
  if (i == 3)
  {
    next
  }
  print(i)
}

for (i in 1:10)
{
  if (i == 4)
  {
    break
  }
  print(i)
}

# repeat loop

y <- 1
repeat
{
  print(y)
  y <- y+1
  if (y == 6)
  {
    break
  }
}

# 