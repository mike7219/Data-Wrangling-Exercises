#
getwd()
setwd("G:/Data Wrangling")
refine_original <- read.csv("refine.csv")

#loading dplyr
library(dplyr)
library(tidyr)
#Visualizing Data
refine_original



#1.) Correcting to "philips"


refine_original$company[agrep("philips", refine_original$company, ignore.case = TRUE, value = FALSE, max.distance = 3)] <- "philips"
refine_original$company[agrep("van houten", refine_original$company, ignore.case = TRUE, value = FALSE, max.distance = 3)] <- "van houten"
refine_original$company[agrep("akzo", refine_original$company, ignore.case = TRUE, value = FALSE, max.distance = 1)] <- "akzo"
refine_original$company[agrep("unilever", refine_original$company, ignore.case = TRUE, value = FALSE, max.distance = 2)] <- "unilever"



#2. ) Seperate column

refine_original <- separate(data = refine_original, col = 'Product.code...number', 
                            into = c("product_code", "product_number"), sep = "-", remove = FALSE)

#3. ) Adding Product Categories 
refine_original <- mutate(refine_original, 'product_category' = product_code)

refine_original$product_category <- gsub("p", "Smartphone", refine_original$product_category)
refine_original$product_category <- gsub("v", "TV", refine_original$product_category)
refine_original$product_category <- gsub("x", "Laptop", refine_original$product_category)
refine_original$product_category <- gsub("q", "Tablet", refine_original$product_category)

#4. ) Add full address column 

refine_original <- unite(data = refine_original, col = 'full_address', "address":"country", sep = "," , remove = FALSE)

#5.1 ) Add four new dummy columns 

refine_original <- mutate(refine_original, 'company_philips' = company)
refine_original <- mutate(refine_original, 'company_akzo' = company)
refine_original <- mutate(refine_original, 'company_van_houten' = company)
refine_original <- mutate(refine_original, 'company_unilever' = company)

#changing company_philips column to binary
refine_original$company_philips <- gsub("akzo", "0", refine_original$company_philips)
refine_original$company_philips <- gsub("van houten", "0", refine_original$company_philips)
refine_original$company_philips <- gsub("unilever", "0", refine_original$company_philips)
refine_original$company_philips <- gsub("philips", "1", refine_original$company_philips)

#changing company_akzo column to binary
refine_original$company_akzo <- gsub("akzo", "1", refine_original$company_akzo)
refine_original$company_akzo <- gsub("van houten", "0", refine_original$company_akzo)
refine_original$company_akzo <- gsub("unilever", "0", refine_original$company_akzo)
refine_original$company_akzo <- gsub("philips", "0", refine_original$company_akzo)

#changing company_van_houten column to binary
refine_original$company_van_houten <- gsub("akzo", "0", refine_original$company_van_houten)
refine_original$company_van_houten <- gsub("van houten", "1", refine_original$company_van_houten)
refine_original$company_van_houten <- gsub("philips", "0", refine_original$company_van_houten)
refine_original$company_van_houten <- gsub("unilever", "0", refine_original$company_van_houten)

#changing company_unilever column to binary
refine_original$company_unilever <- gsub("akzo", "0", refine_original$company_unilever)
refine_original$company_unilever <- gsub("philips", "0", refine_original$company_unilever)
refine_original$company_unilever <- gsub("van houten", "0", refine_original$company_unilever)
refine_original$company_unilever <- gsub("unilever", "1", refine_original$company_unilever)

#5.2 ) Add four more dummy columns 

refine_original <- mutate(refine_original, 'product_smartphone' = product_category)
refine_original <- mutate(refine_original, 'product_tv' = product_category)
refine_original <- mutate(refine_original, 'product_laptop' = product_category)
refine_original <- mutate(refine_original, 'product_tablet' = product_category)

#changing product_smartphone column to binary
refine_original$product_smartphone <- gsub("Smartphone", "1", refine_original$product_smartphone)
refine_original$product_smartphone <- gsub("TV", "0", refine_original$product_smartphone)
refine_original$product_smartphone <- gsub("Laptop", "0", refine_original$product_smartphone)
refine_original$product_smartphone <- gsub("Tablet", "0", refine_original$product_smartphone)

#changing product_tv column to binary
refine_original$product_tv <- gsub("Smartphone", "0", refine_original$product_tv)
refine_original$product_tv <- gsub("TV", "1", refine_original$product_tv)
refine_original$product_tv <- gsub("Laptop", "0", refine_original$product_tv)
refine_original$product_tv <- gsub("Tablet", "0", refine_original$product_tv)

#changing product_laptop column to binary
refine_original$product_laptop <- gsub("Smartphone", "0", refine_original$product_laptop)
refine_original$product_laptop <- gsub("TV", "0", refine_original$product_laptop)
refine_original$product_laptop <- gsub("Laptop", "1", refine_original$product_laptop)
refine_original$product_laptop <- gsub("Tablet", "0", refine_original$product_laptop)

#changing product_tablet column to binary
refine_original$product_tablet <- gsub("Smartphone", "0", refine_original$product_tablet)
refine_original$product_tablet <- gsub("TV", "0", refine_original$product_tablet)
refine_original$product_tablet <- gsub("Laptop", "0", refine_original$product_tablet)
refine_original$product_tablet <- gsub("Tablet", "1", refine_original$product_tablet)


refine_clean <- refine_original


write.csv(refine_draft, file = "refine_clean.csv")

