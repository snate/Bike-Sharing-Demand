# RANDOM FORESTS #
# Load library 'randomForest'
library (randomForest)

# Compute and plot randomForest
rForest = randomForest(F1, data=x, nodesize=1, xtest=x.v, ytest=y.v, mtry=5, keep.forest=TRUE)
plot(rForest)

# Predict response variable values with test set
pRF = predict(rForest, newdata=x.v)
pRF.prob = predict(rForest, newdata=x.v, type="prob")[,2]

# Draw classification results
tabella.sommario(pRF, osserv=y.v)
cat("press <Enter>"); readline()
a21 = lift.roc(pRF.prob, aLotCasualAsNumber, type="crude")