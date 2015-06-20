# LOGISTIC REGRESSION #

#-----------------------------------------------
# Regressione lineare logistica - (aLogistic)
#-----------------------------------------------
#

mLogistic =  glm(F1, family=binomial, data=x)
mLogistic = step(mLogistic, direction = "both")
pLogistic = predict(mLogistic, newdata=x.v, type="response")

tabella.sommario(pLogistic>0.5,y.v)
aLogistic <- lift.roc(pLogistic, aLotCasualAsNumber, type="crude")
