indexes = sample(1:NROW(train),length(train$count)-10)

Aprimo = train[indexes,columns]
y = log(train[indexes,"count"])
X = model.matrix(~., data=Aprimo)

V = diag(1,ncol(X),ncol(X))
beta = matrix( c( mean(y[1]), rep(0, ncol(X) - 1) ), ncol(X), 1 )

beta.storia = matrix(NA, nrow(X), ncol(X))
beta.storia[1,] = beta

for(i in 1 : NROW(X)) {
  H = 1 / (1 + t(X[i,]) %*% V %*% X[i,] )
  beta = beta + H[1] * (V %*% X[i,] %*% (y[i] - t(X[i,] %*% beta)) )
  V = V - H[1] * (V %*% X[i,] %*% t(X[i,]) %*% V )
  beta.storia[i,] = beta
}

beta = matrix(beta)
rownames(beta) = colnames(X)

X11()
par(mfrow = c(3,1))
plot(beta.storia[,1], type="l")
plot(beta.storia[,2], type="l")
plot(beta.storia[,3], type="l")

rm(Aprimo)
rm(H)
rm(V)
rm(X)
rm(i)
rm(y)
rm(indexes)
rm(beta.storia)
#rm(beta)