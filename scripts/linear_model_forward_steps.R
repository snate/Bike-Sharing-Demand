bestProb = 1
#already_present = c(already_present,42)

for(i in 1:length(columns)) {
  if(columns[i] %in% already_present)
    next
  myFrame = train[,c(already_present,columns[i])]
  train.lm2 = lm(log(train$count) ~ .,data = myFrame)
  
  myAnova = anova(train.lm,train.lm2)
  print(columns[i])
  str(myAnova$`Pr(>F)`)
  if(myAnova$`Pr(>F)`[2] < bestProb) {
    bestProb = myAnova$`Pr(>F)`[2]
    best = i
  }
}

if(bestProb < FWD_SW_THRESHOLD) {
  already_present = c(already_present,columns[best])
  myFrame = train[,c(already_present)]
  train.lm = lm(log(train$count) ~ .,data = myFrame)
  print(paste(columns[best], "column has been added to our linear model"))
  source("scripts/linear_model_forward_steps.R")
}

#clean
if(exists("myFrame"))
  rm(myFrame)
if(exists("myAnova"))
  rm(myAnova)
if(exists("bestProb"))
  rm(bestProb)