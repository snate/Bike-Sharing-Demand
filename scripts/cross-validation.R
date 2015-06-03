library(boot)
estimates = matrix(NA, nrow = MAX_P_DEGREE)
colD = colnames(train)

plot(1:MAX_P_DEGREE,estimates,xlab = "Degrees",ylab="Error",ylim=c(1,5))

for(p in 1:MAX_P_DEGREE) {
  d = train
  for(i in 1:length(d)) {
    if(colD[i] %in% columns)
      d[i] = d[i] ^ p
  }
  
  temp = glm(formula = log(count)~season+holiday+workingday+weather+temp+atemp+
              humidity+windspeed+season.summer+season.fall+weather.decent+
              weather.bad,data=d,family= gaussian)
  
  temp = cv.glm(glmfit = temp,data = d, K = 2)
  
  estimates[p] = temp$delta[2]
  
  points(p,estimates[p])
}

rm(d)
rm(i)
rm(colD)
rm(p)
rm(temp)