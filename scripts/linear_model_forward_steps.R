best_aic = AIC(train.lm)
#already_present = c(already_present,42)

for(i in 1:length(columns)) {
  if(columns[i] %in% already_present)
    next
  myFrame = x[,c(already_present,columns[i])]
  train.lm2 = lm(y ~ ., data = myFrame)
  
  aicCur = AIC(train.lm2)
  #myAnova = anova(train.lm,train.lm2)
  #print(columns[i])
  #str(myAnova$`Pr(>F)`)
  if(aicCur < best_aic) {
    best_aic = aicCur
    best = i
  }
}

if(best_aic < AIC(train.lm)) {
  already_present = c(already_present,columns[best])
  myFrame = x[,c(already_present)]
  train.lm = lm(y ~ .,data = myFrame)
  print(paste(columns[best], "column has been added to our linear model"))
  source("scripts/linear_model_forward_steps.R")
}

#clean
if(exists("myFrame"))
  rm(myFrame)
if(exists("myAnova"))
  rm(myAnova)
if(exists("best_aic"))
  rm(best_aic)
if(exists("aicCur"))
  rm(aicCur)