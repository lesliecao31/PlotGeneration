#each colomn of the CSV file contains monte carlo simulation results 
#for amount of wall thickness corrosion at 10, 50, 100 years 
wallThickness <- read.csv("wallCorrosion.csv")


install.packages("MASS")
library(MASS)
library(ggplot2)

#To plot histograms/density plots for the amount of wall corrosion:
ggplot(wallThickness, aes(x=corr10)) + geom_histogram(binwidth = 1)+ xlim(0,300)
ggplot(wallThickness, aes(x=corr50)) + geom_histogram(binwidth = 1)+ xlim(0,300)
ggplot(wallThickness, aes(x=corr100)) + geom_histogram(binwidth = 1)+ xlim(0,300)

#fitdistr function can be used to approximate gamma distributions for the monte carlo simulated wall
#thickness values 
fitdistr(wallThickness$corr10,"gamma")
fitdistr(wallThickness$corr50,"gamma")
fitdistr(wallThickness$corr100,"gamma")

#Plotting gamma distributions using method described by Kallen and van Noortwijk (2005).  
# Need to define nu and mu values first
nu <- #put nu value
mu <- #put mu value

#For linear time
p1 <- ggplot() + labs(x = "X", y = "gamma(t, 1/mu)") +
  geom_line(aes(x=1:50,dgamma(1:50, shape = 50, rate = 1/mu)),color="red") + geom_line(aes(x=1:50,dgamma(1:50, shape = 100, rate = 1/0.164)),color="blue") +
  geom_line(aes(x=1:50,dgamma(1:50, shape = 150, rate = 1/mu)),color="orange") + geom_line(aes(x=1:50,dgamma(1:50, shape = 200, rate = 1/0.164)),color="green") +
  geom_line(aes(x=1:50,dgamma(1:50, shape = 250, rate = 1/mu)),color="yellow") + geom_line(aes(x=1:100,dgamma(1:100, shape = 300, rate = 1/0.164)),color="purple") + 
  geom_line(aes(x=1:100,dgamma(1:100, shape = 350, rate = 1/mu)),color="#79E1D8") + geom_line(aes(x=1:100,dgamma(1:100, shape = 400, rate = 1/0.164)),color="#634602")


#For exponential time
p2 <- ggplot() + labs(x = "X", y = "gamma(t^nu, 1/mu)") +
  geom_line(aes(x=1:30,dgamma(1:30, shape = 50^nu, rate = 1/mu)),color="red") + geom_line(aes(x=1:30,dgamma(1:30, shape = 100^0.7815, rate = 1/0.164)),color="blue") +
  geom_line(aes(x=1:30,dgamma(1:30, shape = 150^nu, rate = 1/mu)),color="orange") + geom_line(aes(x=1:30,dgamma(1:30, shape = 200^0.7815, rate = 1/0.164)),color="green") +
  geom_line(aes(x=1:30,dgamma(1:30, shape = 250^nu, rate = 1/mu)),color="yellow") + geom_line(aes(x=1:30,dgamma(1:30, shape = 300^0.7815, rate = 1/0.164)),color="purple") + 
  geom_line(aes(x=1:30,dgamma(1:30, shape = 350^nu, rate = 1/mu)),color="#79E1D8") + geom_line(aes(x=1:30,dgamma(1:30, shape = 400^0.7815, rate = 1/0.164)),color="#634602")

#Print plots to pdf files: 
pdf("gamma_linear.pdf")
print(p1)
dev.off()

pdf("gamma_exponential.pdf")
print(p2)
dev.off()




1- pgamma(12.7, shape = 440^0.7815, rate = 1/0.164)
