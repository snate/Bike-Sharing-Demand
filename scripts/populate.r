test = read.csv(file="data/test.csv")
test$datetime = as.Date(test$datetime)
train = read.csv(file="data/train.csv")
train$datetime = as.Date(train$datetime)
