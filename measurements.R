# File:   measurements.R

# INSTALL AND LOAD PACKAGES ################################

# INSTALLS PACMAN IF IT ISN'T INSTALLED ALREADY
if (!require("pacman")) install.packages("pacman")

# USES PACMAN TO LOAD ADD-ONS
pacman::p_load(pacman, rio)

# ACTUALLY IMPORTS DATA
paqA <- import("./Datasets/paqA.csv")
paqB <- import("./Datasets/paqB.csv")
paqD <- import("./Datasets/paqD.csv")
micH <- import("./Datasets/micH.csv")

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
        main = "Comprimento do lado A em cm",
        varwidth = T,
        horizontal = TRUE
)

boxplot(paqB$Size,
        main = "Comprimento do lado B em cm",
        varwidth = T,
        horizontal = TRUE
)

boxplot(paqD$Size,
        main = "Diâmetro do furo na peça em cm",
        varwidth = T,
        horizontal = TRUE
)

# CALCULATES STANDARD ERROR

## FUNCTION CALCULATES STANDARD ERROR FOR GIVEN VECTOR
std <- function(a) sd(a) / sqrt(length(a))

## THIS BLOCK CALCULATES THE SE FOR THE DIFFERENT DATASETS
errA <- std(c(3.6350, 3.6100, 3.6350, 3.6100, 3.6350, 3.6110, 3.6100, 3.6350, 3.6100, 3.6300))
print(errA)

errB <- std(c(4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600))
print(errB)

errD <- std(c(1.7200, 1.7200, 1.7200, 1.7200, 1.7100, 1.7050, 1.7200, 1.7200, 1.7000, 1.7200))
print(errD)

errH <- std(c(1.2525, 1.2500, 1.2499, 1.2499, 1.2498, 1.2509, 1.2489, 1.2505, 1.2498, 1.2510))
print(errH)


# UNUSED VECTORS
#paqA <- c(3.6350, 3.6100, 3.6350, 3.6100, 3.6350, 3.6110, 3.6100, 3.6350, 3.6100, 3.6300)
#paqB <- c(4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600, 4.1600)
#paqD <- c(1.7200, 1.7200, 1.7200, 1.7200, 1.7100, 1.7050, 1.7200, 1.7200, 1.7000, 1.7200)
#micH <- c(1.2525, 1.2500, 1.2499, 1.2499, 1.2498, 1.2509, 1.2489, 1.2505, 1.2498, 1.2510)


# CLEAR ENVIRONMNENT
rm(list = ls())

# CLEAR PACKAGES
p_unload(all)  # Remove all add-ons

# CLEAR CONSOLE
cat("\014")  # ctrl+L

# CLEAR PLOT (IF THERE IS A PLOT)
dev.off()
