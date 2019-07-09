#Pacotes necessario
#install.packages('stringr')
library(stringr)

#install.packages('dplyr')
library(dplyr)

#install.packages("data.table")
library(data.table)

#install.packages('randomForest')
library(randomForest)

#install.packages('caret')
library(caret)

#install.packages('caTools')
library(caTools)

#install.packages('ggplot2')

library(ggplot2)

#install.packages('lattice')
library(lattice)

#install.packages('e1071')
library('e1071')
getwd()
setwd('C:/Users/1712082018/Documents/R/Cluster')

#importando
trem <- read.csv(file = 'dados_adolescentes.csv', sep=',', stringsAsFactors = FALSE,
                 
                 encoding='UTF-8')
dados <- trem
summary(dados)

table(dados$gender, useNA = 'ifany')

#ados_limpos <- dados[dados$age >=13 & dados$age <20,]
summary(dados_limpos)
dados_limpos <- dados
dados_limpos$age <- ifelse(dados_limpos$age >= 13 & dados_limpos$age <20, dados_limpos$age, NA)
summary(dados_limpos$age)

medias <- ave( dados_limpos$age, dados_limpos$gradyear, FUN=function(x) mean(x, na.rm=TRUE))
medias

dados_limpos$age <- ifelse(is.na(dados_limpos$age), medias, dados_limpos$age)
table(dados_limpos$gender, useNA = 'ifany')

dados_limpos <- dados_limpos[!is.na(dados_limpos$gender),]
interesses <- dados_limpos[,5:40]
clusters <- kmeans(interesses, 5)
dados_limpos$cluster <- clusters$cluster
aggregate(data=dados_limpos, age ~cluster, mean)
