getwd()
setwd("G:/Data Wrangling")

titanic_original <- read.csv("titanic_original.csv")
library(tidyr)
library(dplyr)

str(titanic_original)
# 1.) Replacing empty strings with "S"

titanic_original$embarked

titanic_original$embarked[titanic_original$embarked == ''] <- NA

titanic_original$embarked

titanic_original$embarked[which(is.na(titanic_original$embarked))] <- "S"

titanic_original$embarked

# 2.1) Replace missing values in AGE with the mean
titanic_original$age

median(titanic_original$age, na.rm = TRUE)

mean <- mean(titanic_original$age, na.rm = TRUE)

titanic_original$age[which(is.na(titanic_original$age))] <- mean

titanic_original$age

# 2.2) Why would you pick mean in this instance? Or not?
# The mean seems like the correct choice because there are over 1000 observations 
# and that negates any significant bias in one direction or another. Median is also 
# a good option because both the median and mean are very close.

# 3.) Fill in the missing boat column with NA

titanic_original$boat

titanic_original$boat[titanic_original$boat == ''] <- NA

titanic_original$boat

# 4.) Create new column has_cabin_number and make it binary

titanic_original <- mutate(titanic_original, 'has_cabin_number' = cabin )

titanic_original$has_cabin_number[titanic_original$has_cabin_number == ''] <- NA



titanic_original$has_cabin_number <- as.numeric(is.na(titanic_original$has_cabin_number) == 0)

titanic_original$has_cabin_number

titanic_clean <- titanic_original

write.csv(titanic_clean, file = "titanic_clean.csv")
