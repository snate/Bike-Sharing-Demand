#regression splines (cubiche)
library(splines)

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

plot(x,y,pch=2,col=2,main="splines di regressione")
points(x,y.v,pch=3,col=3)

#si provi con un po' di parametri di lisciamento (numero nodi)
#poi si perviene a

xi = seq(min(x),max(x),length=13)
xx = sort(c(x,xi[2:(length(xi)-1)]))
m1 = lm(y~bs(x,knots=xi[2:(length(xi)-1)],degree=3))
fit1 = predict(m1,data.frame(x=xx))
lines(xx,fit1)
#si disegnano le linee che separano i polinomi
for(i in 1:length(xi)) {
  abline(v=xi[i], lty=3)
}

##per trovare il migliore numero di nodi via validation
nummin = 3
num = 25
val = matrix(NA,num,2)
for (i in nummin:num){
  h = i
  val[i,1] = h
  xi= seq(min(x),max(x),length=i+2)
  xx = sort(c(x,xi[2:(length(xi)-1)]))
  m1 = lm(y~bs(x,knots=xi[2:(length(xi)-1)],degree=3))
  
  val[i,2] = sum((y.v-predict(m1))^2)
}
plot(val[nummin:num,1], val[nummin:num,2],xlab="Numero di nodi",ylab="Errore")
print(val[nummin:num,])
val = na.omit(val)
bestVal = min(val[,2])
pos = val[,1][val[,2]==bestVal]
print(paste("Wow",bestVal,"in position",pos))
cat("Premere <Enter>"); readline()

#disegno spline con il migliore numero di nodi
plot(x,y,pch=2,col=2,main="splines di regressione",xlab="temp",ylab="count")
points(x,y.v,pch=3,col=3)
xi<-seq(min(x),max(x),length=pos)
xx<-sort(c(x,xi[2:(length(xi)-1)]))
m1<-lm(y~bs(x,knots=xi[2:(length(xi)-1)],degree=3))
fit1<-predict(m1,data.frame(x=xx))
lines(xx,fit1,col=4)
#si disegnano le linee che separano i 3 polinomi
for(i in 1:length(xi)) {
  abline(v=xi[i], lty=3)
}

rm(bestVal)
rm(fit1)
rm(h)
rm(i)
rm(indexes)
rm(indexes.v)
rm(m1)
rm(num)
rm(nummin)
rm(pos)
rm(val)
rm(x)
rm(x.v)
rm(xi)
rm(xx)
rm(y)
rm(y.v)
