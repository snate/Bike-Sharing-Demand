x = train$temp
y = train$count

plot(x,y,col=3,pch=3)
sm1 = sm.regression(x,y,h=optimal,add=TRUE,ngrid=120)
