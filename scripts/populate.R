# read tables
test = read.csv(file="data/test.csv")
test$datetime = as.POSIXct(test$datetime)
test$datetime = strptime(test$datetime, "%Y-%m-%d %H:%M:%S")
test$datetime <- as.numeric(format(test$datetime, "%H"))
train = read.csv(file="data/train.csv")
train$datetime = as.POSIXct(train$datetime)
train$datetime = strptime(train$datetime, "%Y-%m-%d %H:%M:%S")
train$datetime <- as.numeric(format(train$datetime, "%H"))

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

#FACTOR HOURS
test$datetime = factor(test$datetime)
train$datetime = factor(train$datetime)

# COSTANTS
FWD_SW_THRESHOLD = 0.1
MAX_P_DEGREE = 30
columns = colnames(test)
F1 = as.formula(paste("log(train$count)~",paste(names(train[-c(10:12)]), collapse="+")))
