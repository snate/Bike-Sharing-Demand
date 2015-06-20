library(nnet)

FN = as.formula(paste("aLotRegistered~",paste(names(train[-c(10:12,15)]), collapse="+")))

parte1<- sample(1:NROW(train), 8000) 
parte2<- setdiff(1:NROW(train), parte1)

#---
#selezione del weight decay
#ci mette molto tempo
#---
decay<- 10^(seq(-3, -1, length=10))
err <- rep(0,10)
for(k in 1:10){
  n1<- nnet(FN, data=train[parte1,], decay=decay[k], size=5,
            maxit=100,  trace=FALSE)
  p1n<- predict(n1, newdata=train[parte2,], type="class")
  a = tabella.sommario(p1n, train[parte2,]$aLotRegistered)
  err[k] <-  1-sum(diag(a))/sum(a)
  print(c(err[k], decay[k]))
}
#
#
n2<- nnet(FN, data=train[parte1,], decay=min(decay), size=5,  maxit=1000)
p7<- predict(n1, newdata=x.v, type="class")
#
tabella.sommario(p7,y.v)
a7<- lift.roc(p7, aLotRegisteredAsNumber, type="crude")
