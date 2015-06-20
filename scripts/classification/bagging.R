# BAGGING #
# Load library 'ipred'
library(ipred)
library(rpart)

# nbagg= numero di alberi da costruire
# coob= Calcola l'out of bag; cioÃ‹ scelgo le osservazioni non scelte dal primo bootstrap come insieme di valutazione

bag = bagging(y~.,data=x,nbagg=25, control=rpart.control(minsplit=2, cp=0, xval=0))
pbag = predict(bag,newdata=x.v)

# Draw classification results
tabella.sommario(pbag, y.v)
print(42)
pbag.prob = predict(bag,newdata=x.v, type="prob")[,2]
abag = lift.roc(pbag.prob, aLotCasualAsNumber, type="bin")
