library(tree)
Ftree = as.formula(paste("log(count)~",paste(names(train[-c(10:12)]), collapse="+")))
indexes = sample(1:length(train$count), size=length(train$count)/2 + 1)
indexes.v = sample(setdiff(1:length(train$count), indexes))

x = train[c(columns,"count")]
x$datetime = as.numeric(x$datetime)
y = train$count

x.v = x[indexes.v,]
x = x[indexes,]

parte1 = sample(1:NROW(x),length(indexes)/2)
parte2 = setdiff(1:NROW(x),parte1)

# Creazione dell'albero completo con threshold per devianza = .02
t1 = tree(Ftree, data= x[parte1,], control = tree.control(nobs=length(parte1),minsize=2, mindev = 0.02))  # fino alle foglie
plot(t1)
text(t1)
cat("press <Enter>"); readline()

# Arrivo alla potatura dell'albero
t2 = prune.tree(t1, newdata = x[parte2,])
plot(t2)
cat("press <Enter>"); readline()

J = t2$size[t2$dev == min(t2$dev)]

# Poto l'albero e il risultato è in t3
t3 = prune.tree(t1, best=J)
plot(t3)
text(t3)

# Pulisco workspace
rm(Ftree)
rm(indexes)
rm(indexes.v)
rm(parte1)
rm(parte2)
rm(t1)
rm(t2)
rm(x)
rm(x.v)
rm(y)
