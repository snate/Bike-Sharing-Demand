indexes = sample(1:length(train$count), size=length(train$count)/2)
indexes.v = sample(setdiff(1:length(train$count), indexes))
str(indexes)
str(indexes.v)

x = train$temp
str(x)
x.v = x[indexes.v]
x = x[indexes]
y = log(train$count)
y.v = y[indexes.v]
y = y[indexes]

#per trovare il migliore par. di span via validation
nummin = 1
num = 10
val = matrix(NA,num,2)
for(i in nummin:num) {
  h=i/10
  val[i,1]<-h
  lo1 <- loess(y~x,span=h)
  val[i,2]<-sum((y.v-predict(lo1))^2)
}

plot(val[nummin:num,1],val[nummin:num,2],xlab="parametro di lisciamento",ylab="errore 'dati di oggi'")
print(val[nummin:num,])
optimal_span = min(val[,2])
optimal_span = val[,1][val[,2] == optimal_span]
print(paste("Optimal span is",optimal_span))

lo1 <- loess.smooth(x,y,span=optimal_span)
plot(x,y,pch=2,col=2,main="loess")
points(x,y.v,pch=3,col=3)
lines(lo1)

rm(i)
rm(indexes)
rm(indexes.v)
rm(h)
rm(lo1)
rm(num)
rm(nummin)
rm(val)
rm(x)
rm(x.v)
rm(y)
rm(y.v)