# MARS - CLASSIFICATION #
# Load library 'earth'
library(earth)

library(polspline)
mars2 = earth(F1,data=x)
p6 = predict(mars2,x.v)

tabella.sommario(p6>0.5, y.v)
a6<- lift.roc(p6, aLotRegisteredAsNumber, type="crude")
