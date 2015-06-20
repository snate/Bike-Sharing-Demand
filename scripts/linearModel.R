if(!is.factor(train$datetime))
  train$datetime = factor(train$datetime)
r2 = rep(0,length(columns)); fstatistic = rep(0,length(columns))

indexes = sample(1:length(train$count), size=length(train$count)/2)
indexes.v = sample(setdiff(1:length(train$count), indexes))

x = train[columns]
y = log(train$count)
x.v = x[indexes.v,]
x = x[indexes,]
y.v = y[indexes.v]
y = y[indexes]


for(i in 1:length(columns)) {
  print(columns[i])
  myCol = x[columns[i]]
  train.lm = lm(y ~ ., data = myCol)
  r2[i] = summary(train.lm)$r.squared
  fstatistic[i] = summary(train.lm)$fstatistic[1]
  print(paste(columns[i], "has R-squared:", r2[i], " and F-statistic: ", fstatistic[i]))
}

best = 1
for(i in 2:length(columns)) {
  if(fstatistic[i] > fstatistic[best])
    best = i
}

print(paste(columns[best], "has best F-statistic:", fstatistic[best]))
print(paste(columns[best], "will be used to calculate the linear model w/ 1 variable"))

train.lm = lm(y ~ ., data = x[columns[best]])
already_present = c(columns[best])
source("scripts/linear_model_forward_steps.R")
print(already_present)

pLinear = predict(train.lm,x.v)
aLinear = lift.roc(pLinear, y.v, type="crude")

#clean
rm(already_present)
rm(best)
rm(fstatistic)
rm(i)
rm(indexes)
rm(indexes.v)
rm(myCol)
rm(pLinear)
rm(r2)
rm(x)
rm(x.v)
rm(y)
rm(y.v)
