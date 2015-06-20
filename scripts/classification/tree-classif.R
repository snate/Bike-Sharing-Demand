# TREE - CLASSIFICATION #
# Load library 'tree'
library(tree)

# Convert hours to numbers
train$datetime = as.numeric(train$datetime)
x.v$datetime = as.numeric(x.v$datetime)

# Set formula to compute neural network
FT = as.formula(paste("aLotCasual~",paste(names(train[-c(10:12,15)]), collapse="+")))

# Find whole tree
parte1<- sample(1:NROW(train), 8000) 
parte2<- setdiff(1:NROW(train), parte1)
#
t1c<- tree(FT, data=train[parte1,], control=tree.control(nobs=length(parte1), minsize=2, mindev=0.01))
plot(t1c)
text(t1c,cex=0.8)
cat("press <Enter>"); readline()

# Find deviance for all the subtrees of t1
t2c<- prune.tree(t1c, newdata=train[parte2,])
plot(t2c)
J <- t2c$size[t2b$dev==min(t2c$dev)]
cat("press <Enter>"); readline()

# Get the tree with best size (and minimum deviance)
t3c<-prune.tree(t1c, best=J)
plot(t3c)
text(t3c)
cat("press <Enter>"); readline()

# 
pTREEb = predict(t3c, newdata=x.v, type="class")
tabella.sommario(pTREEb,y.v)
pTREE <-  predict(t3c, newdata=x.v, type="vector")[,2]
atree <- lift.roc(pTREE,aLotCasualAsNumber,type="crude")