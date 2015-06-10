if(!is.factor(train$datetime))
  train$datetime = factor(train$datetime)
r2 = rep(0,length(columns)); fstatistic = rep(0,length(columns))

for(i in 1:length(columns)) {
  print(columns[i])
  myCol = train[columns[i]]
  train.lm = lm(log(train$count)~., data = myCol)
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

train.lm = lm(log(train$count) ~ ., data = train[columns[best]])

already_present = c(columns[best])
source("scripts/linear_model_forward_steps.R")
print(already_present)

#clean
rm(i)
rm(best)
rm(r2)
rm(fstatistic)
rm(already_present)
rm(myCol)
