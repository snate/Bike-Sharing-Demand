library(sm)
#smoothing splines
indexes = sample(1:length(train$count), size=length(train$count)/2)
indexes.v = sample(setdiff(1:length(train$count), indexes))
column = "temp"

if(column == "datetime")
  x = as.numeric(train[column])
x = train[column]
str(x)
x.v = x[indexes.v,column]
x = x[indexes,column]
y = log(train$count)
y.v = y[indexes.v]
y = y[indexes]

plot(x,y,pch=2,col=2,main="Splines di lisciamento")
points(x,y.v,pch=3,col=3)

myFrame = data.frame(x,y)
levs = unique(x)
med = rep(0,length(levs))
i = 0
for(l in levs) {
  i = i + 1
  cnt = length(with(myFrame, y[x==l]))
  med[i] = sum(with(myFrame, y[x==l])) / cnt
}

x_old = x
y_old = y
x = levs;
y = med;

myFrame = data.frame(x.v,y.v)
levs = unique(x.v)
med = rep(0,length(levs))
i = 0
for(l in levs) {
  i = i + 1
  cnt = length(with(myFrame, y.v[x.v==l]))
  med[i] = sum(with(myFrame, y.v[x.v==l])) / cnt
}

x.v = levs
y.v = med

s1 <- smooth.spline(x,y)
lines(s1)

cat("premere <Enter>"); readline()

#si cerca il miglior lambda grazie a X-validation
nummin <- 1
num <- 100
val <- matrix(NA,num,2)
for (i in nummin:num){
  h=i/100
  val[i,1]<-h
  s1 <- smooth.spline(x,y,spar=h)
  val[i,2]<-sum((y.v-predict(s1)$y)^2)
}
plot(val[nummin:num,1], val[nummin:num,2],xlab="Lambda",ylab="Errore")
val[nummin:num,]
val = na.omit(val)
bestVal = min(val[,2])
pos = val[,1][val[,2]==bestVal]
print(paste("Best:",bestVal,"in position",pos))
cat("premere <Enter>"); readline()

plot(x_old,y_old,pch=2,col=2,main="Splines di lisciamento",xlab=column,ylab="Bike sharing request")
points(x.v,y.v,pch=3,col=3)
s1 <- smooth.spline(x,y,spar=pos)
lines(s1)

rm(bestVal)
rm(cnt)
rm(h)
rm(i)
rm(indexes)
rm(indexes.v)
rm(l)
rm(levs)
rm(med)
rm(myFrame)
rm(num)
rm(nummin)
rm(pos)
rm(s1)
rm(val)
rm(x)
rm(x_old)
rm(x.v)
rm(y)
rm(y_old)
rm(y.v)
