
# Code typed from slide 9
plot(diamonds$carat,diamonds$price,
     xlab = "Carat",
     ylab = "Price",
     main = "Carat vs Price for Diamonds",
     type = "o",
     col = "red")
par(col = "blue")
plot(diamonds$carat,diamonds$price)

# More Graphical Parameters
plot(diamonds$carat,diamonds$price,
     xlab = "Carat",
     ylab = "Price",
     main = "Carat vs Price for Diamonds",
     type = "o",
     col = "orange",
     col.main = "darkgray",
     cex.axis = 0.6,
     lty = 5,
     pch = 4)

# Multiple Plots
par(mfrow=c(2,2))
plot(diamonds$carat,diamonds$price)
plot(diamonds$price,diamonds$carat)
plot(diamonds$cut,diamonds$price)
plot(diamonds$color,diamonds$price)

par(mfcol=c(2,2))
plot(diamonds$carat,diamonds$price)
plot(diamonds$price,diamonds$carat)
plot(diamonds$cut,diamonds$price)
plot(diamonds$color,diamonds$price)

# Reset the grid
par(mfrow=c(1,1))
plot(diamonds$cut,diamonds$price)

#layout()
grid <- matrix(c(1,2,3,3),nrow=2,ncol=2,byrow=TRUE)
grid
layout(grid)
plot(diamonds$carat,diamonds$price)
plot(diamonds$price,diamonds$carat)
plot(diamonds$cut,diamonds$price)

# Reset the grid
layout(1) 
par(mfcol = c(1,1))

# Stack the graphical elements
ranks <- order(diamonds$carat)
plot(diamonds$carat, diamonds$price,
       pch = 16, col = 2,
       xlab = "Carat",
       ylab = "Price")
lm_price <- lm(diamonds$carat ~ diamonds$price)
abline(coef(lm_price), lwd = 2)
lines(diamonds$carat[ranks], diamonds$price[ranks])
