library(sm)
x = train$datetime
y = log(train$count)
#interv = 10:100
#divisions= 10
#interv = 500:700
#divisions= 100
#interv = 6000:6500
#divisions= 1000
interv = 64700:64750
divisions= 10000

#possiamo dire che 1,652 è il migliore valore per h

plot(x,y,col=3,pch=3)

val = matrix(NA, length(interv),1)
for (i in interv) {
  inc = i / divisions
  sm1 = sm.regression(x,y,h=inc,add=TRUE,ngrid=120,col=2)
  val[i-min(interv)] = sum((y[1:120]-sm1$estimate)^2)
}

plot((interv)/divisions,val)

val = val[1:(length(val)-1)]
i = which(val == min(val))
optimal_h = interv[i]/divisions

rm(divisions)
rm(i)
rm(inc)
rm(interv)
rm(sm1)
rm(x)
rm(val)
rm(y)