library(sm)
x = train$temp
y = train$count
#interv = 50:300
#divisions= 100

plot(x,y,col=3,pch=3)

val = matrix(NA, length(interv),1)
for (i in interv) {
  inc = i / divisions
  sm1 = sm.regression(x,y,h=inc,add=TRUE,ngrid=120)
  val[i-min(interv)] = sum((y[1:120]-sm1$estimate)^2)
}

plot((interv)/100,val)

rm(divisions)
rm(i)
rm(inc)
rm(interv)
rm(sm1)
rm(x)
rm(y)