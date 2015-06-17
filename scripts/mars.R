# MARS #
# Load library 'earth'
library(earth)

Fmars = as.formula(paste("y~",paste(names(train[-c(10:12)]), collapse="+")))

indexes = sample(1:length(train$count), size=length(train$count)/2)
indexes.v = sample(setdiff(1:length(train$count), indexes))

x = train[columns]
y = log(train$count)

x.v = x[indexes.v,]
x = x[indexes,]
y.v = y[indexes.v]
y = y[indexes]

mars = earth(Fmars,data=x)
plot(mars)
cat("press <Enter>"); readline()
evimp(mars)
plot(evimp(mars))
cat("press <Enter>"); readline()

p6 = predict(mars,x.v)
a6 = lift.roc(p6, y.v, type="crude")

rm(a6)
rm(p6)
rm(indexes)
rm(indexes.v)
rm(x)
rm(x.v)
rm(y)
rm(y.v)