#initial view of the source data
drawMain <- function(){
  colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")
  plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species],asp = 1)
}
drawMain()

#distance function
Distance <- function(u, v) {
  sqrt(sum((u - v)^2))
}

#���������� KNN 
KNN <- function(x,z, k){
  n <- 150 #row
  m <- 2 #col
  distMatrix <- matrix(NA, n, m)
  for (i in n:1){
    distMatrix[i,] <- c(i, Distance(x[i,1:m], z))
  }
  sortflowers <- x[order(distMatrix[,2])[1:k],m+1] #order - sort index
  ans <- names(which.max(table(sortflowers))) # which.max - index of max element
  return(ans)
}

#Draw knn
drawKNN <- function(z1,z2){
  points(z1, z2, pch = 22, col = colors[KNN(iris[,3:5],c(z1,z2), 7)])
}

#comparison function
test <- function(){
text <- paste("W=", 1 ," L=",2.5,sep="")
#drawKNN(2.5, 1)
drawKWNN(2.5, 1)
text(2.55,1.05,labels=text)
}
#test()


#MAP KNN
DrawMap1 <- function(){
  for (i in seq(0,7,0.1)) {
    for (j in seq(0,2.5,0.1)){
      drawKNN(i,j)
    }
  }
}
#DrawMap1()

#LOO KNN
LOOKNN <- function(x){
  n <- 150 #row
  m <- 2 # col
  #print(m)
  loo <- rep(0,n) #repeat 0 n times
  for(i in 1:n){
    x1 <- x[-i,] # delete element
    x2 <- dim(x1)[1]
    distMatrix <- matrix(NA, x2, m)
    for (j in x2:1){
      distMatrix[j,] <- c(j, Distance(x1[j,1:m], x[i,1:m])) #dist
    }  
    ordered <- order(distMatrix[,2])
    for(k in 1:n){
      flowers <- x[ordered[1:k],m+1]
      ans <- names(which.max(table(flowers)))
      if(ans != x[i,m+1]) {
        loo[k] <- loo[k] + 1/n
      }
    }
  }
  #print(loo)
  #print(which.min(loo))
  finalK <- which.min(loo)
  minLOO <- min(loo)
  print(minLOO)
 # text <- paste("k=",finalK,"\nLOO=",minLOO,sep="")
  plot(loo,type = "l",xlab = "k", ylab="loo")
  points(finalK, minLOO, pch=22, col="black", bg="black")
 # text(finalK + 15,minLOO+ 0.1,labels=text)
}
#LOOKNN(iris[3:5])



# KWNN
KWNN <- function(x,z,k,w){
  m <- 150
  n <- 2
  distMatrix <- matrix(NA, m, n)
  for (i in m:1)  
    distMatrix[i,] <- c(i, Distance(x[i,1:n], z))
  
  ordered <- x[order(distMatrix[,2])[1:k],]
  sortedFlowers <- names(table(ordered[,n+1]))
  worth <- rep(0,length(sortedFlowers))
  
  for(i in 1:k)
    worth[ordered[i,3]] <- worth[ordered[i, 3]] + w^i
  
  ans <- sortedFlowers[which.max(worth)]
  return(ans)
}


#draw KWNN
drawKWNN <- function(z1,z2){
  points(z1, z2, pch = 22, col = colors[KWNN(iris[,3:5],c(z1,z2),6,0.05)])
}
#drawKWNN(2.2, 1.5)


#LOO KWNN
LOOKWNN <- function(x, k=6){
  m <- 150
  n <- 2
  q <- seq(0.05,0.95,0.05)
  len <- length(q)
  loo <- rep(0,len)
  for(i in 1:m){
    x1 <- x[-i,]
    x2 <- dim(x1)[1]
    
    distMatrix <- matrix(NA, x2, n)
    for (j in x2:1){
      distMatrix[j,] <- c(j, Distance(x1[j,1:n], x[i,1:n]))
    }  
    
    ordered <- x1[order(distMatrix[,2])[1:k],]
    sortFlowers <- names(table(ordered[,n+1]))
    
    for(w in 1:len){
      worth <- rep(0,length(sortFlowers))
      for(j in 1:k)
        worth[ordered[j,3]] <- worth[ordered[j,3]] + w^q[j]
      ans <- sortFlowers[which.max(worth)]
      if(ans != x[i,n+1]) {
        loo[w] <- loo[w] + 1/m
      }
    }
  }
  finalq = q[which.min(loo)]
  finalLOO = min(loo)
  #print(loo)
  #print(which.min(loo))
  text <- paste("q = ", q,"\nLOO=",loo)
  plot(q,loo,type = "l",xlab = "q", ylab="LOO")
  points(finalq + 0.001, finalLOO + 0.0004, pch=22, col="black", bg="black")
  text(finalq + 0.2,finalLOO+0.003,labels=text)
  print(finalq);
}
LOOKWNN(iris[3:5])

#MAP KWNN

DrawMap2 <- function(){
  for (i in seq(0,7,0.1)) {
    for (j in seq(0,2.5,0.1)){
      drawKWNN(i,j)
    }
  }
}
DrawMap2()
