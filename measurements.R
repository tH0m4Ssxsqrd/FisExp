# File:   measurements.R

##########################################
#This notebook is supposed to help calculate the volume, density and the associated error that comes from the experiment and pure randomness.
#Este programa pretende ajudar a calcular o volume, densidade e erro associado ao processo experimental que vem de fatores aleatórios.

#This notebook was written to be used as such. Do read and understand what each part does, and load the required packages,
#datasets and functions in order to calculate whatever you want to.

#Este programa foi escrito para ser rodado como um notebook. Leia o programa e tente entender o que cada parte faz, lembrando
#de carregar os pacotes, datasets e funções necessárias para calcular o que quiser.
##########################################

# INSTALL AND LOAD PACKAGES ##########################################

# INSTALLS PACMAN IF IT ISN'T INSTALLED ALREADY
if (!require("pacman")) install.packages("pacman")

# USES PACMAN TO LOAD ADD-ONS
pacman::p_load(pacman, rio)

# ACTUALLY IMPORTS DATA
paqA <- import("./Datasets/paqA.csv")
paqB <- import("./Datasets/paqB.csv")
paqD <- import("./Datasets/paqD.csv")
micH <- import("./Datasets/micH.csv")
massa <- 123 #MEASURED MASS
erropaq <- 0.0025 #PRECISION OF THE CALIPER RULER IN CM
erromic <- 0.0005 #PRECISION OF THE MICROMETER IN CM

# VIEW DATA
?View
View(paqA)
View(paqB)
View(paqD)
View(micH)

# ARRANGES THE DATA IN PLOTS
plot(paqA)
plot(paqB)
plot(paqD)
plot(micH)

# GENERATES BOX PLOTS
boxplot(paqA$Size,
        main = "Variação das medidas de A",
        xlab = "Em cm",
        horizontal = TRUE
)

boxplot(paqB$Size,
        main = "Variação das medidas de B",
        xlab = "Em cm",
        horizontal = TRUE
)

boxplot(paqD$Size,
        main = "Variação do diâmetro",
        xlab = "Em cm",
        horizontal = TRUE
)

boxplot(micH$Size,
        main = "Variação das medidas de H",
        xlab = "Em cm",
        horizontal = TRUE
)

# CALCULATES STANDARD ERROR

## FUNCTION CALCULATES STANDARD ERROR FOR GIVEN VECTOR

std <- function(a) sd(a) / sqrt(length(a)) #STANDARD ERROR
sde <- function(a) sd(a) #STANDARD DEVIATION
med <- function(a) mean(a) #ARITHMETHIC MEAN

## THIS BLOCK CALCULATES THE SE, SD AND MEAN FOR THE DIFFERENT DATASETS

A <- c(3.6350, 3.6100, 3.6350, 3.6100, 3.6350, 3.6110, 3.6100, 3.6350, 3.6100, 3.6300)
B <- c(4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600)
D <- c(1.7200, 1.7200, 1.7200, 1.7200, 1.7100, 1.7050, 1.7200, 1.7200, 1.7000, 1.7200)
H <- c(1.2525, 1.2500, 1.2499, 1.2499, 1.2498, 1.2509, 1.2489, 1.2505, 1.2498, 1.2510)

#FOR THE A SIDE
errA <- std(A)
sdeA <- sde(A)
medA <- med(A)
print(errA)
print(sdeA)
print(medA)

#FOR THE B SIDE
errB <- std(B)
sdeB <- sde(B)
medB <- med(B)
print(errB)
print(sdeB)
print(medB)

#FOR THE DIAMETER
errD <- std(D)
sdeD <- sde(D)
medD <- med(D)
print(errD)
print(sdeD)
print(medD)

#FOR THE HEIGHT
errH <- std(H)
sdeH <- sde(H)
medH <- med(H)
print(errH)
print(sdeH)
print(medH)


#FINAL CALCULATIONS AND OUTPUT

##EXPERIMENTAL ERROR
errAt <- errA + erropaq
errBt <- errB + erropaq
errDt <- errD + erropaq
errHt <- errH + erromic

errvol <- abs(medB*medH)*errAt + abs(medA*medH)*errBt + abs(medA*medB - pi*((medD/2)^2))*errHt + abs((pi * medD * medH)/2)*errDt

errden <- (1/vol) + (massa/((vol)^2))*errvol

##VOLUME
volF <- function(a, b, d, h) ((a*b -pi*((d/2)^2))*h)
vol <- volF(medA, medB, medD, medH)

print(paste("O volume da peça é de", vol, "±", errvol, "cm³"))

#DENSITY
den <- massa/vol
print(paste("A densidade da peça é de", den, "±", errden, "g/cm³"))

##########################################
# CLEAR ENVIRONMNENT
rm(list = ls())

# CLEAR PACKAGES
p_unload(all)  # Remove all add-ons

# CLEAR CONSOLE
cat("\014")  # ctrl+L

# CLEAR PLOT (IF THERE IS A PLOT)
dev.off()

