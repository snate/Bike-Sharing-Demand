# NEURAL NETWORKS - CLASSIFICATION #
# Load library 'nnet' and graphic tools
library(nnet)
library(devtools)
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

# Set formula to compute neural network
FN = as.formula(paste("aLotCasual~",paste(names(train[-c(10:12,15)]), collapse="+")))
parte1 = sample(1:NROW(train), 8000) 
parte2 = setdiff(1:NROW(train), parte1)

# Find best decay for neural network
decay = 10^(seq(-3, -1, length=10))
err = rep(0,10)
for(k in 1:10){
  n1 = nnet(FN, data=train[parte1,], decay=decay[k], size=5,
            maxit=100,  trace=FALSE)
  p1n = predict(n1, newdata=train[parte2,], type="class")
  a = tabella.sommario(p1n, train[parte2,]$aLotCasual)
  err[k] =  1-sum(diag(a))/sum(a)
  print(c(err[k], decay[k]))
}

# Compute a neural network with the best decay found in previous step
n2 = nnet(FN, data=train[parte1,], decay=min(decay), size=5,  maxit=1000)
pNET = predict(n1, newdata=x.v, type="class")

# Draw classification results
tabella.sommario(p7,y.v)
a7 = lift.roc(p7, aLotCasualAsNumber, type="crude")