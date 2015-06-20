# GAM #
library(gam)

gam2 =  gam(F1, family=binomial, data=x)
pGAM = predict(gam2,newdata=x.v,type="response")

err.gamc2 = tabella.sommario(pGAM>0.5,y.v)
err.gamc2

summary(gam2)
aGAM = lift.roc(pGAM, aLotCasualAsNumber, type="crude")

cat("press <Enter>"); readline()
plot(gam2,ask=TRUE)
