# PLOT ALL LIFTS #

# Plot all lift lines
plot(aLogistic[[1]], aLogistic[[2]], type="b", 
     cex=0.75, col=1, pch=1,
     xlab="Frazione di soggetti previsti", ylab="Fattore di miglioramento",
     xlim=c(0,1), ylim=c(1,5))
lines(aRF[[1]], aRF[[2]], type="b", cex=0.75, col=9, lty=9, pch=11)
lines(aMARS[[1]], aMARS[[2]], type="b", cex=0.75, col=2, lty=2, pch=2)
lines(aGAM[[1]], aGAM[[2]], type="b", cex=0.75, col=3, lty=3, pch=3)
lines(aNET[[1]], aNET[[2]], type="b", cex=0.75, col=4, lty=4, pch=4)
lines(atree[[1]], atree[[2]], type="b", cex=0.75, col=5, lty=5, pch=5)
lines(abag[[1]], abag[[2]], type="b", cex=0.75, col=6, lty=6, pch=6)
lines(aBoosting[[1]], aBoosting[[2]], type="b", cex=0.75, col=8, lty=8, pch=8)

legend(0.7,5,c("Modello logistico","MARS","GAM","Rete neurale","CART","Bagging","Boosting","Random forests"),
       col=c(1,2,3,4,5,6,8,9),
       lty=c(1,2,3,4,5,6,8,9),
       pch=c(1,2,3,4,5,6,8,11))
