# TREE #
library(tree)

train$datetime = as.numeric(train$datetime)
x.v$datetime = as.numeric(x.v$datetime)

FT = as.formula(paste("aLotRegistered~",paste(names(train[-c(10:12,15)]), collapse="+")))

parte1<- sample(1:NROW(train), 8000) 
parte2<- setdiff(1:NROW(train), parte1)
#
t1b<- tree(FT, data=train[parte1,], control=tree.control(nobs=length(parte1), minsize=2, mindev=0.01))
plot(t1b)
text(t1b,cex=0.8)
cat("press <Enter>"); readline()

t2b<- prune.tree(t1b, newdata=train[parte2,])
plot(t2b)
J <- t2b$size[t2b$dev==min(t2b$dev)]
cat("press <Enter>"); readline()
#
t3b<-prune.tree(t1b, best=J)
plot(t3b)
text(t3b)
cat("press <Enter>"); readline()
#
pp5b<- predict(t3b, newdata=x.v, type="class")
tabella.sommario(pp5b,y.v)
p5b <-  predict(t3b, newdata=x.v, type="vector")[,2]
a5b <- lift.roc(p5b,aLotRegisteredAsNumber,type="crude")
