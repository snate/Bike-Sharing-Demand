# read tables
test = read.csv(file="data/test.csv")
test$datetime = as.Date(test$datetime)
train = read.csv(file="data/train.csv")
train$datetime = as.Date(train$datetime)

# separate answers in another table
train.answer = train[,10:12]
train = train[,-c(10:12)]

#SEASONS#
# summer
train$season.summer = rep(0,length(train$season))
train$season.summer[train$season == 2] = 1
test$season.summer = rep(0,length(test$season))
test$season.summer[test$season == 2] = 1
# fall
train$season.fall = rep(0,length(train$season))
train$season.fall[train$season == 3] = 1
test$season.fall = rep(0,length(test$season))
test$season.fall[test$season == 3] = 1
# bring all to 0 except spring
test$season[test$season == 2] = 0
test$season[test$season == 3] = 0
test$season[test$season == 4] = 0
train$season[train$season == 2] = 0
train$season[train$season == 3] = 0
train$season[train$season == 4] = 0