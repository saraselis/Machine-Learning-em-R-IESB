#Pacotes necessario
#install.packages('stringr')
library(stringr)

#install.packages('dplyr')
library(dplyr)

#install.packages('ggplot2')
library(ggplot2)

#install.packages("data.table")
library(data.table)

#install.packages('randomForest')
library(randomForest)

#install.packages('caret')
library(caret)

#install.packages('caTools')
library(caTools)


#install.packages('lattice')
library(lattice)

getwd()
setwd('F:/Estudos/Machine-Learning-em-R-IESB-master/projeto')

#importando
trem <- read.csv(file = 'dataset.csv', sep=',', stringsAsFactors = FALSE,
                 
                 encoding='UTF-8')
dados <- trem



#######Coluna Sepal.lenght#######
table(dados$Sepal.Length)
summary(dados$Sepal.Length)

dados$Sepal.Length <- gsub(pattern = ',', replacement = '.', x = dados$Sepal.Length)
dados$Sepal.Length <- as.numeric(dados$Sepal.Length)
summary(dados$Sepal.Length)



#######Coluna Sepal.widht#######
summary(dados$Sepal.Width)

dados$Sepal.Width <- gsub(pattern = '\\$', replacement = '\\', x=dados$Sepal.Width)
dados$Sepal.Width <- as.numeric(dados$Sepal.Width)
summary(dados$Sepal.Width)

summary(dados$Species)
table(dados$Species)




#######Coluna Petal.Widht#######
summary(dados$Petal.Width)
table(dados$Petal.Width)

dados$Petal.Width <- gsub(pattern = '\\*', replacement = '\\', x = dados$Petal.Width)
dados$Petal.Width <- as.numeric(dados$Petal.Width)

summary(dados$Petal.Width)
table(dados$Petal.Width)

#######Coluna Petal.lenght#######
summary(dados$Petal.Length)
table(dados$Petal.Length, useNA = "ifany")

dados$Petal.Length <- gsub(pattern = ',', replacement = '.', x = dados$Petal.Length)
dados$Petal.Length <- gsub(pattern = '\\*', replacement = '\\', x = dados$Petal.Length)
dados$Petal.Length <- as.numeric(dados$Petal.Length)
summary(dados$Petal.Length)

dados <- na.omit(dados)


#media_pl <- dados %>% group_by(Species) %>% summarise(media = mean(Petal.Length, na.rm=T))

#dados[is.na(dados$Petal.Length) & (dados$Species == 'SETOSA'), 'Petal.Length']<- 
 # media_pl[media_pl$Species == 'SETOSA', 'media']

#dados[(is.na(dados$Petal.Length) & (dados$Species == 'VIRGINICA') ), 'Petal.Length']<- 
 # media_pl[media_pl$Species == 'VIRGINICA', 'media']

d#ados[(is.na(dados$Petal.Length) & (dados$Species == 'VERSICOLOR') ), 'Petal.Length']<- 
  #media_pl[media_pl$Species == 'VERSICOLOR', 'media']
summary(dados$Petal.Length)


#######Coluna Species #######
#######Species#######

dados$Species <- gsub(pattern = '_setosa_', replacement = 'SETOSA', x=dados$Species)
dados$Species <- gsub(pattern = '_versicolor_', replacement = 'VERSICOLOR', x=dados$Species)
dados$Species <- gsub(pattern = '_virginica_', replacement = 'VIRGINICA', x=dados$Species)

#media_2 <- dados %>% group_by(Species) %>% summarise(media = mean(Sepal.Length, na.rm=T))


#Guardando os trem
dados$X <- NULL
dados_ok <- dados

dados_ok$Species <- as.factor(dados_ok$Species)
summary(dados_ok$Species)

########Classificacao#######
div_valores <- sample.split(dados_ok$Species, SplitRatio = 0.8)
table(div_valores)

dados_ok$flag <- div_valores
dados_treino  <- dados_ok[dados_ok$flag == T,]
dados_teste   <- dados_ok[dados_ok$flag == F,]
dados_treino$flag <- NULL
dados_teste$flag       <- NULL

summary(dados_treino)
summary(dados_teste)

modelo_rf <- randomForest(Species ~., data = dados_treino)
modelo_rf

#View(dados_teste)
pred_rf   <- predict(modelo_rf, dados_teste[,-c(5)]) 
pred_rf
table(pred_rf)

dados_teste$pred <- pred_rf
View(dados_teste)


atual     <- dados_teste$Species
predicted <- as.factor(pred_rf)

#CF
cof_matrix <- caret::confusionMatrix(predicted, atual)
metricas   <- as.data.frame(cof_matrix$byClass)
View(metricas)

#Precision
precision (pred_rf, atual)


#F1
F1_Score(atual, predicted, positive= NULL)

#Recall
recall(data=dados_ok)


#########CLUSTER#######
ms <- dados_ok[,1:4]
clusters <- kmeans(ms, 4)
dados_ok$clusters <- clusters$cluster
print(clusters)
