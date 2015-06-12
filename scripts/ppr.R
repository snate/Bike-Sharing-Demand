# Projection Pursuit Regression
indexes = sample(1:length(train$count), size=length(train$count)/2)
indexes.v = sample(setdiff(1:length(train$count), indexes))

x = train[columns]
x$datetime = as.numeric(x$datetime)
y = train$count

x.v = x[indexes.v,]
x = x[indexes,]
y = log(train$count)
y.v = y[indexes.v]
y = y[indexes]

UB = 20

errors = rep(0,UB)

for(k in 1:UB) {
  ppr1 = ppr(y ~ ., data=x, nterms = k)
  mppr1 = pmax(predict(ppr1,newdata=x.v), .5)
  pPPR = predict(ppr1,newdata=x.v,type="response")
  errors[k] = sum((y.v-pPPR)^2)
  print(paste("Done PPR with k = ", k, "-- error: ", errors[k]))
}

bestK = which.min(errors)
print(paste("Index ", bestK, " has best error: ",errors[bestK]))

plot(1:UB, errors, xlab = "k", ylab="Errore")

cat("press <Enter>"); readline()

ppr1 = ppr(y ~ ., data=x, nterms = bestK)
pPPR = predict(ppr1,newdata=x.v,type="response")

aPPR = lift.roc(pPPR, y.v, type="crude")

rm(aPPR)
rm(bestK)
rm(errors)
rm(indexes)
rm(indexes.v)
rm(k)
rm(mppr1)
rm(pPPR)
#rm(ppr1)
rm(UB)
rm(x)
rm(x.v)
rm(y)
rm(y.v)