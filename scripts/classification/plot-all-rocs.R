# PLOT ALL ROC #

# Plot all ROC lines
plot(aLogistic[[3]], aLogistic[[4]], type="b", 
     cex=0.75, col=1, pch=1,
     xlab="1-specificità", ylab="sensibilità",
     xlim=c(0,1), ylim=c(0,1))
lines(aRF[[3]], aRF[[4]], type="b", cex=0.75, col=9, lty=9, pch=11)
lines(aMARS[[3]], aMARS[[4]], type="b", cex=0.75, col=2, lty=2, pch=2)
lines(aGAM[[3]], aGAM[[4]], type="b", cex=0.75, col=3, lty=3, pch=3)
lines(aNET[[3]], aNET[[4]], type="b", cex=0.75, col=4, lty=4, pch=4)
lines(atree[[3]], atree[[4]], type="b", cex=0.75, col=5, lty=5, pch=5)
lines(abag[[3]], abag[[4]], type="b", cex=0.75, col=6, lty=6, pch=6)
lines(aBoosting[[3]], aBoosting[[4]], type="b", cex=0.75, col=8, lty=8, pch=8)

legend(0.7,0.7,c("Modello logistico","MARS","GAM","Rete neurale","CART","Bagging","Boosting","Random forests"),
       col=c(1,2,3,4,5,6,8,9),
       lty=c(1,2,3,4,5,6,8,9),
       pch=c(1,2,3,4,5,6,8,11))
