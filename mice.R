install.packages("VIM")
install.packages("naniar")
install.packages("missMDA")
install.packages("Amelia")
install.packages("mice")
install.packages("missForest")
install.packages("FactoMineR")
install.packages("Tidyverse")
library(dplyr)
library(VIM)
library(FactoMineR)
library(missMDA)
library(mice)
library(missRanger)
library(tidyr)

#data <- read.csv("~/Downloads/Chalice Family Dollar Q4 2022 (Raw) (8).csv")
#data <- read.csv("~/Downloads/Chalice Family Dollar Q4 2022 (Raw).csv")



data <- as.data.frame(unclass(data),stringsAsFactors=TRUE)

#custom <- as.data.frame(data[,c(16)])
custom <- as.data.frame(data[,c(18)])


#custom <- as.data.frame(data[,c(16)])

custom = custom %>% separate(`data[, c(18)]`, c("c1","c2", "c3", "c4", "c5"), ",")

custom = custom %>% separate(c1, c("var","c1"), ":")
custom$c1 = (gsub('[[:punct:] ]+',' ',custom$c1))
custom = custom %>% separate(c2, c("var","c2"), ":")
custom$c2 = (gsub('[[:punct:] ]+',' ',custom$c2))
custom = custom %>% separate(c3, c("var","c3"), ":")
custom$c3 = (gsub('[[:punct:] ]+',' ',custom$c3))

custom = custom %>% separate(c4, c("var","c4"), ":")
custom$c4 = (gsub('[[:punct:] ]+',' ',custom$c4))

custom = custom %>% separate(c5, c("var","c5"), ":")
custom$c5 = (gsub('[[:punct:] ]+',' ',custom$c5))

custom$var <- NULL

data = cbind(data,custom)



##### Predictive mean matching (multiple imputation)#####
data <- data %>% mutate_all(na_if,"")

#df = data %>% dplyr::select(c(19:29, 87:91))

#df = data %>% dplyr::select(c(21:31, 77:81))


df = data %>% dplyr::select(c(21:31, 77:81))
final <- data[,-c(21:31, 77:81)]

non_miss <- rowSums(!is.na(df))
m <- missRanger(df, num.trees = 100, pmm.k = 2, seed = 5, case.weights = non_miss, returnOOB = TRUE,   maxiter = 10L)
(attr(m, "oob"))

n$attr.m...oob.. = n$attr.m...oob..*100












final = cbind(final,m)

write.csv(final, "~/Downloads/fam_dollar.csv")


library(ggplot2)
ggplot(df, aes(x=dose, y=len, fill=dose)) +
  geom_bar(stat="identity")+theme_minimal()


mydata %>%
  filter(!is.na(neighborhood)) %>% # filter on non-missing values
  ggplot(aes(x = neighborhood, # x is neighborhood
             fill = neighborhood)) + # fill is neighborhood
  geom_bar()



ggplot()+
  geom_bar(data = subset(data, !is.na(Device)), aes(x=Device, fill = "blue", na.rm = TRUE), width = 0.3)+
  geom_bar(data = subset(m, !is.na(Device)), aes(x=Device, fill = "yellow", na.rm = TRUE),
           position = position_nudge(x = 0.25), width = 0.3)+
  
  theme_minimal() +   labs(fill = "") + scale_fill_discrete(labels=c('Raw Data', 'Imputed Data'))



table(final$Demo.State, final$Creative.Name)








