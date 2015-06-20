# MARS - CLASSIFICATION #
# Load library 'earth'
library(earth)

# Find MARS model and predict values
mars2 = earth(F1,data=x)
pMARS = predict(mars2,x.v)

# Draw classification results
tabella.sommario(pMARS>0.5, y.v)
aMARS = lift.roc(pMARS, aLotCasualAsNumber, type="crude")
