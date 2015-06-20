#------------
#GAM
#------------
# 
library(gam)
#-------
#esercizio di con poche variabili esplicative, da usare a lezione
#

gam2 =  gam(F1, family=binomial, data=x)
pGAM = predict(gam2,newdata=x.v,type="response")
#
err.gamc2 = tabella.sommario(pGAM>0.5,y.v)
err.gamc2
#
summary(gam2)
a8b = lift.roc(pGAM, aLotRegisteredAsNumber, type="crude")

cat("press <Enter>"); readline()
plot(gam2,ask=TRUE)
