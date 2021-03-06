naive_Bayes <- function(Py, lambda, n, m, mu, sigma, point){
  
  p <- rep(0, m)
  
  for (i in 1:m) {
    
    p[i] <- Py[i] * lambda[i]
    
    for (j in 1:n) {
      
      p[i] <- p[i] * exp((-(point[j] - mu[i, j])^2 * (1/sigma[i, j]))/2) / sqrt(2 * pi * sigma[i, j])
      
    }
    
  }
  
  return(classes[which.max(p)])
  
}

set <- iris[ , 3:5]

row <- dim(set)[1]
col <- dim(set)[2]

num_classes <- table(set[3])
classes <- unique(set[, 3])
colors <- c("setosa" = "red", "versicolor" = "green", "virginica" = "blue")

# ���������� ��������� � ���������� �������
n <- col - 1 
m <- dim(num_classes)

# ��������� �����������
Py <- rep(0, m) 

for (i in 1:m) {
  Py[i] <- num_classes[i] / row
}

# ����������� � ���������
mu <- matrix(0, m, n)
sigma <- matrix(0, m, n)

for (i in 1:m) {
  
  for (j in 1:n) {
    
    #print(set[set[, 3] == classes[i], ][, j])
    
    mu[i, j] <- mean(set[set[, 3] == classes[i], ][ , j])
    sigma[i, j] <- var(set[set[, 3] == classes[i], ][ , j])
    
  }
  
}


lambda <- c(1, 1, 100)


plot(
  set[ , 1], set[ , 2], 
  pch = 21, bg = colors[set[, 3]], col = colors[set[, 3]],
  xlab = "����� ��������", ylab = "������ ��������",
  main = "����� ������������� (������� ���������� ����������� �������������)",
  xlim = c(1, 7), ylim = c(0, 2.5)
)


# ����� �������������
for (i in seq(0.8, 7.2, 0.1)) {
  
  for (j in seq(-0.3, 2.9, 0.1)) {
    
    points(i, j, pch = 1, col = colors[naive_Bayes(Py, lambda, n, m, mu, sigma, c(i, j))])
    
  }
  
}


legend(
  "bottomright",
  pch = c(19, 19, 19),
  col = c("red", "green4", "blue"),
  legend = c("setosa", "versicolor", "virginica")
)


Q <- 0

for (i in 1:row) {
  
  class <- naive_Bayes(Py, lambda, n, m, mu, sigma, set[i, 1:2])
  
  if (class != set[i, 3]) {
    
    Q <- Q + 1
    
  }
}

Q <- Q / row

print(Q)