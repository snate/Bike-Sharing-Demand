library(polspline)
indexes = sample(1:length(train$count), size=length(train$count)/2)
indexes.v = sample(setdiff(1:length(train$count), indexes))

x = train[columns]
y = train$count

x.v = x[indexes.v,]
x = x[indexes,]
y = log(train$count)
y.v = y[indexes.v]
y = y[indexes]

mars<-polymars(y,x)
p6 = predict(mars,x.v)
a6<- lift.roc(p6, y.v, type="crude")

rm(a6)
rm(p6)
rm(indexes)
rm(indexes.v)
rm(x)
rm(x.v)
rm(y)
rm(y.v)