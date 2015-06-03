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

#WEATHER#
# decent
train$weather.decent = rep(0,length(train$weather))
train$weather.decent[train$weather == 2] = 1
test$weather.decent = rep(0,length(test$weather))
test$weather.decent[test$weather == 2] = 1
# bad
train$weather.bad = rep(0,length(train$weather))
train$weather.bad[train$weather == 3] = 1
test$weather.bad = rep(0,length(test$weather))
test$weather.bad[test$weather == 3] = 1
# bring all to 0 except good
test$weather[test$weather == 2] = 0
test$weather[test$weather == 3] = 0
test$weather[test$weather == 4] = 0
train$weather[train$weather == 2] = 0
train$weather[train$weather == 3] = 0
train$weather[train$weather == 4] = 0

# COSTANTS
FWD_SW_THRESHOLD = 0.05
MAX_P_DEGREE = 30
columns = colnames(test)
