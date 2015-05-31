columns = colnames(test)
r2 = rep(0,length(columns)); fstatistic = rep(0,length(columns))
for(i in 2:length(columns)) {
  name = columns[i]
  r2[i] = (cov(train[name],train$count)^2) / (var(train[name]) * var(train$count))
  fstatistic[i] = r2[i] * (length(train$count) - 2) / (1 - r2[i])
  print(paste(name, "has R-squared:", r2[i], " and F-statistic: ", fstatistic[i]))
}
best = 2
for(i in 3:length(columns)) {
  if(fstatistic[i] > fstatistic[best])
    best = i
}
print(paste(columns[best], "has best F-statistic:", fstatistic[best]))
print(paste(columns[best], "will be used to calculate the linear model w/ 1 variable"))

train.lm = lm(train$count ~ ., data = train[columns[best]])

#clean
rm(name)
rm(columns)
rm(i)
rm(best)
rm(r2)
rm(fstatistic)
