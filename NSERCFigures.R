options(scipen=999)  # turn-off scientific notation
library(ggplot2)
theme_set(theme_bw())

# Scatterplot for bending failure LSF
bendingFail <- read.csv("BendingFailure_original.csv")
pdf("BF_original_scatterplot.pdf",width = 15, height = 12)
ggplot(bendingFail, aes(x=time, y=per_fail)) + 
  geom_point() + 
  geom_line() + 
  labs(y="Probability of failure, Pf", 
       x="Time to failure (yr)", 
       title="Time to failure vs. Probability of failure",
       caption = "For bending failure limit state function")

dev.off()

#Scatterplot for wall thickness LSF
wallThickness <- read.csv("WallThickness_original.csv")
pdf("WT_original_scatterplot.pdf",width = 15, height = 12)
ggplot(wallThickness, aes(x=time, y=per_fail)) + 
  geom_point() + 
  geom_line() + 
  labs(y="Probability of failure, Pf", 
       x="Time to failure (yr)", 
       title="Time to failure vs. Probability of failure",
       caption = "For wall thickness limit state function")

dev.off()

#Combined scatterplot for WT and SC 
bendingFail$LSF = "BF"
bendingFail$num_fail = NULL
wallThickness$LSF = "WT"
combined = rbind(bendingFail,wallThickness)
  
p <- ggplot(bendingFail, aes(x=time, y=per_fail)) + geom_point(col = "red") + geom_line(colour = "red") +
  labs(y="Probability of failure, Pf", 
       x="Time to failure (yr)", 
       title="Time to failure vs. Probability of failure",
       caption = "For bending failure (red) and wall thickness (blue) limit state functions")
plot <- p + geom_point(data=wallThickness, col = "blue") + geom_line(data = wallThickness, colour = "blue", show.legend = TRUE)

pdf("BFWT_combined_original_scatterplot.pdf",width = 15, height = 12)
print(plot)
dev.off()

#Distribution of kappa 
kappa <- read.csv("kappa.csv")
library(ggplot2)
theme_set(theme_classic())

# Plot density plot for kappa
g <- ggplot(kappa, aes(kappa)) + xlim(c(0,1))
g<- g + geom_density() + 
  labs(title="Density plot of kappa values",
       x="kappa")

pdf("kappa_density_plot.pdf",width = 15, height = 12)
print(g)
dev.off()

#Distribution of nu
nu <- read.csv("nu.csv")

n <- ggplot(nu, aes(nu))
n <- n + geom_density() + 
  labs(title="Density plot of nu values",
       x="nu")

pdf("nu_density_plot.pdf",width = 15, height = 12)
print(n)
dev.off()

#kappa and nu, side by side boxplots 
kappa <- as.data.frame(kappa$kappa)
kappa$variable <- "kappa"
kappa$value <- kappa$kappa
kappa$`kappa$kappa`=NULL

nu <- as.data.frame(nu$nu)
nu$variable <- "nu"
nu$value <- nu$nu
nu$`nu$nu`=NULL

kappa_nu <- rbind(kappa,nu)

m <- ggviolin(kappa_nu, x = "variable", y = 'value', color = 'variable',
         add = "boxplot") + 
  labs(title="Violin plots for kappa and nu",
       x="Variable",
       y="Value")

pdf("nu_kappa_vlnplot.pdf",width = 15, height = 12)
print(m)
dev.off()


## For experimental bending failure 
bendingFail.exp <- read.csv("BendingFailure_exp.csv")
pdf("BF_exp_scatterplot.pdf",width = 15, height = 12)
ggplot(bendingFail.exp, aes(x=time, y=per_fail)) +
  geom_point() + 
  geom_line() + 
  labs(y="Probability of failure, Pf", 
       x="Time to failure (yr)", 
       title="Time to failure vs. Probability of failure",
       caption = "For experimental bending failure limit state function")

dev.off()

## For experimental wall thickness 
wallThickness.exp <- read.csv("WallThickness_exp.csv")
pdf("WT_exp_scatterplot.pdf",width = 15, height = 12)
ggplot(wallThickness.exp, aes(x=time, y=per_fail)) +
  geom_point() + 
  geom_line() + 
  labs(y="Probability of failure, Pf", 
       x="Time to failure (yr)", 
       title="Time to failure vs. Probability of failure",
       caption = "For experimental wall thickness limit state function")

dev.off()

#Combined scatterplot for experimental WT and SC 
bendingFail$LSF = "BF"
bendingFail$num_fail = NULL
wallThickness$LSF = "WT"
combined = rbind(bendingFail,wallThickness)

p <- ggplot(bendingFail.exp, aes(x=time, y=per_fail)) + geom_point(col = "red") + geom_line(colour = "red") +
  labs(y="Probability of failure, Pf", 
       x="Time to failure (yr)", 
       title="Time to failure vs. Probability of failure",
       caption = "For experimental bending failure (red) and wall thickness (blue) limit state functions")
plot <- p + geom_point(data=wallThickness.exp, col = "blue") + geom_line(data = wallThickness.exp, colour = "blue", show.legend = TRUE)

pdf("BFWT_combined_exp_scatterplot.pdf",width = 15, height = 12)
print(plot)
dev.off()

