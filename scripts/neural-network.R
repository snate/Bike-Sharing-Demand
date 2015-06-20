#RETI NEURALI
library(nnet)
library(devtools)
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

Fnet = as.formula(paste("count~",paste(names(train[-c(10:12)]), collapse="+")))
indexes = sample(1:length(train$count), size=length(train$count)/2 + 1)
indexes.v = sample(setdiff(1:length(train$count), indexes))

x = train[c(columns,"count")]
x$datetime = as.numeric(x$datetime)

x.v = x[indexes.v,]
x = x[indexes,]

n1 = nnet(Fnet, data = x, decay = 0.0016, size = 5, maxit = 100)
pNN = predict(n1, newdata = x.v)

#tabella.sommario(pNN,x.v$count)
lift.roc(pNN,x$count,type="crude")

#rm(Fnet)
rm(indexes)
rm(indexes.v)
rm(x)
rm(x.v)