library(boot)
if(!is.numeric(train$datetime))
  train$datetime = as.numeric(train$datetime)
errors = matrix(NA, nrow = MAX_P_DEGREE)
bestCol = "datetime"
form_temp = paste("log(count)~",bestCol)
numbers = sample(1:length(train$count), size = length(train$count)/2)
str(numbers)
numbers.other = sample(setdiff(1:length(train$count),numbers))
str(numbers.other)

plot(1:MAX_P_DEGREE,errors,xlab = "Degrees",ylab="Error",ylim=c(0,5))

for(p in 1:MAX_P_DEGREE) {
  d = train[,c("count",bestCol)]
  d[bestCol] = d[bestCol] ** p
  d.stima = d[numbers,]
  d.v = d[numbers.other,]
  
  #temp.lm = lm(form_temp, data = d.stima)
  #p1 = predict(object = temp.lm, newdata = d.v)
  temp.glm = glm(form_temp, data = d.stima, family= gaussian)
  temp = cv.glm(glmfit = temp.glm, data = d, K = 2)
  
  errors[p] = summary(temp.glm)$deviance
  
  points(p,errors[p])
  print(paste("Errore in ", p ,": ", errors[p]))
}

plot(1:MAX_P_DEGREE,errors,xlab = "Degrees",ylab="Error")

rm(d)
rm(bestCol)
rm(p)
#rm(temp)
#rm(errors)
rm(numbers)
rm(numbers.other)
rm(form_temp)
rm(d.stima)
rm(d.v)