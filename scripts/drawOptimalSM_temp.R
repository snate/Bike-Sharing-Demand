x = train$temp
y = log(train$count)

plot(x,y,col=3,pch=3)
sm1 = sm.regression(x,y,h=optimal_h,add=TRUE,ngrid=120,col=2)

rm(x)
rm(y)