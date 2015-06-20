source("scripts/populate.R")

train$aLotCasual = rep(0, length(train$registered))

for(i in 1:length(train$registered)) {
  if(train$casual[i] > 50)
    train$aLotCasual[i] = 1
}

train$aLotCasual = as.factor(train$aLotCasual)

F1 = as.formula(paste("y~",paste(names(train[-c(10:12,15)]), collapse="+")))

indexes = sample(1:length(train$count), size=length(train$count)/2)
indexes.v = sample(setdiff(1:length(train$count), indexes))

x = train[columns]
y = train$aLotCasual
x.v = x[indexes.v,]
x = x[indexes,]
y.v = y[indexes.v]
y = y[indexes]
aLotCasualAsNumber = as.numeric(y.v == 1)
