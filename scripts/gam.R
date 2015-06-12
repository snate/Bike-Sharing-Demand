#------------
#GAM
#------------
# 
library(gam)
#-------
indexes = sample(1:length(train$count), size=length(train$count)/2)
indexes.v = sample(setdiff(1:length(train$count), indexes))
Fgam = as.formula(paste("y~",paste(names(train[-c(10:12)]), collapse="+")))

x = train[columns]
x$datetime = as.numeric(x$datetime)
y = train$count

x.v = x[indexes.v,]
x = x[indexes,]
y = log(train$count)
y.v = y[indexes.v]
y = y[indexes]

gam1 <-  gam(Fgam, family=gaussian, data=x)
p8 <- predict(gam1,newdata=x.v,type="response")
#
summary(gam1)
plot(gam1, ask=T)

a8<- lift.roc(p8, y.v, type="crude")

rm(a8)
rm(Fgam)
rm(indexes)
rm(indexes.v)
rm(p8)
rm(x)
rm(x.v)
rm(y)
rm(y.v)
