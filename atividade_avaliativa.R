#- Criar um modelo de classificação da qualidade de vinhos para DUAS classes, ruim (menor que 6)
#e bom (maior ou igual a 6).

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

getwd()
setwd('F:/Estudos/Machine-Learning-em-R-IESB-master/Classificação')

#importando
trem <- read.csv(file = 'dados_vinhos.csv', sep=';', stringsAsFactors = FALSE,

                                 encoding='UTF-8')
dados_vinhos <- trem

#explorando
head(dados_vinhos)
summary(dados_vinhos)

table(dados_vinhos$type)
table(dados_vinhos$citric.acid)
table(dados_vinhos$alcohol)

barplot(table(dados_vinhos$type))
barplot(table(dados_vinhos$alcohol))

#Preprocessando os dados

#Corrigindo o type (trocando 0 e 1)
dados_vinhos$type <- gsub(pattern = '0', replacement = 'Red', x = dados_vinhos$type)
table(dados_vinhos$type)

dados_vinhos$type <- gsub(pattern = '1', replacement = 'White', x = dados_vinhos$type)
table(dados_vinhos$type)

#Consertando Citric
dados_vinhos$citric.acid <- gsub(pattern = ',', replacement = '.', dados_vinhos$citric.acid)
summary(dados_vinhos$citric.acid)

#Convertendo alcohol
dados_vinhos$alcohol <- as.numeric(dados_vinhos$alcohol)
summary(dados_vinhos)

#Calculando a media de cada tipo de vinho
media_type <- dados_vinhos %>% group_by(type) %>% summarise(media = mean(alcohol, na.rm=T))

#Substituindo os NA do VER e BRA
dados_vinhos[(is.na(dados_vinhos$alcohol) ) & (dados_vinhos$type == 'Red'),'alcohol'] <- 
  media_type[media_type$type == 'Red','media']

dados_vinhos[(is.na(dados_vinhos$alcohol) ) & (dados_vinhos$type == 'White'),'alcohol'] <- 
  media_type[media_type$type == 'White','media']

summary(dados_vinhos$alcohol)

#Convertendo a qualidade p classes ruim(menos q 6), bom(mais q 6)
dados_vinhos$classe <- ifelse(dados_vinhos$quality <= 6, 'Ruim',
                              ifelse(dados_vinhos$quality > 6, 'Bom', 1))
table(dados_vinhos$classe)

####Começando modelo
dados_duas_clas <- dados_vinhos

#Factor
dados_duas_clas$classe <- as.factor(dados_duas_clas$classe)
summary(dados_duas_clas)


#excluindo colunas q n irão para o modelo 
dados_duas_clas$type    <- NULL
dados_duas_clas$alcohol <- NULL
dados_duas_clas$quality <- NULL

#construindo o modelo
library(caTools)

#train test
set.seed(2345)
div_valores <- sample.split(dados_duas_clas$classe, SplitRatio = 0.8)
table(div_valores)

dados_duas_clas$flag <- div_valores
dados_treino <- dados_duas_clas[dados_duas_clas$flag ==T, ]
dados_teste  <- dados_duas_clas[dados_duas_clas$flag == F,]
dados_treino$flag <- NULL
dados_teste$flag  <- NULL

summary(dados_treino)
summary(dados_teste)
#View(dados_teste)
#modelo
set.seed(2345)
modelo_rf <- randomForest(classe ~., data = dados_treino)
modelo_rf

pred_rf <- predict(modelo_rf, dados_teste[,-c(11)], type='class')
#tirando a classe p n enviesar o trem
pred_rf
table(pred_rf)


dados_teste$pred <- pred_rf

View(dados_teste)

## avaliando o modelo com matiz de confusão, acurárica, precision (sensitivity), recall (specificity)
atual     <- dados_teste$classe
predicted <- as.factor(pred_rf)

## salvando a matrix de confusão (confusion matrix) em um objeto
cof_matrix <- caret::confusionMatrix(predicted, atual)

## convertendo as métricas de avaliação em um data frame
metricas <- as.data.frame(cof_matrix$byClass)

View(metricas)
