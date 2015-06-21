# BOOSTING #
# Load library 'ipred'
library(ada)

boosting = ada(y~., data=x, iter=50)

#Draw boosting plots
plot(boosting)
plot(boosting, F,T)

# Draw classification results
pBoosting = predict(boosting, newdata=x.v)
tabella.sommario(pBoosting, osserv=y.v)
cat("press <Enter>"); readline()
pBoosting.prob = predict(boosting, newdata=x.v, type="prob")[,2]
aBoosting = lift.roc(pBoosting.prob, aLotCasualAsNumber, type="crude")
