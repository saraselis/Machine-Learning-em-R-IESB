#Verificando e setando o diretório
getwd()
setwd("C:/Users/1712082018/Documents/R")

#Importando o arquivo
df=read.csv(file = 'dados_vinhos.csv', sep = ';', stringsAsFactors = FALSE, encoding = 'UTF-8')

#Análise exploratória
str(df)
summary(df)
head(df)

#backup do dataset
dados <- df
head(dados)


dados$type = gsub(pattern='1', replacement='Red', x=dados$type, ignore.case = FALSE)
dados$type = gsub(pattern='0', replacement='White', x=dados$type, ignore.case = FALSE)

summary(dados)

dados$citric.acid = gsub(pattern=',', replacement='.', x=dados$citric.acid, ignore.case = FALSE)
dados$citric.acid <- as.numeric(x = dados$citric.acid)


dados$alcohol <- as.numeric(x = dados$alcohol)
#mean(dados$alcohol, na.rm =T)
#summary(dados$alcohol)

dados$novo_alcohol <- dados$alcohol

#dados$alcohol = gsub(pattern= "Na", replacement= '10.42', x=dados$alcohol)
#dados$alcohol <- as.numeric(x = dados$alcohol)
#dados[is.na(dados$alcohol), "alcohol"] <- 10.42
#dados[is.na(dados$alcohol),"alcohol"] - mean(dados$alcohol, na.rm =T) #media geral


media_red <-dados[dados$type =='Red' & !is.na(dados$novo_alcohol), 'novo_alcohol'] 
media_red <- mean(media_red)
media_red
dados[dados$type =='Red' & is.na(dados$novo_alcohol), 'novo_alcohol'] = media_red
summary(dados$novo_alcohol)


media_bra <-dados[dados$type =='White' & !is.na(dados$novo_alcohol), 'novo_alcohol'] 
media_bra <- mean(media_bra)
media_bra
dados[dados$type =='White' & is.na(dados$novo_alcohol), 'novo_alcohol'] = media_red
summary(dados$novo_alcohol) ############


#Converter coluna Quality para texto:
  # - Menor que 5, ruim (0)
  # - Entre 5 e 7, bom (1)
  # - maior que 7, ótimo (2)


dados$classe = dados$quality
dados$classe = as.character(x=dados$quality)
dados[dados$classe <5, 'classe'] = 0 
dados[dados$classe >=5 & dados$classe <=7, 'classe'] = 1
dados[dados$classe >7, 'classe'] = 2
dados$classe = as.numeric(x=dados$quality)
summary(dados$classe)
table(dados$classe)

dados$classe <- as.factor(dados$classe)
summary(dados$novo_alcohol)



#install.packages('caTools')
library(caTools)
dados_limpos <- dados
summary(dados$novo_alcohol)

dados_limpos$type <- NULL
dados_limpos$alcohol <- NULL 
dados_limpos$quality <-NULL
set.seed(2345)
div_valores <-sample.split(dados_limpos$classe , SplitRatio = 0.8)
table(div_valores)
dados_limpos$flag <- div_valores
summary(dado)

dados_treino <- dados_limpos[dados_limpos$flag == T,]
dados_treino$flag <- NULL
dados_test <- dados_limpos[dados_limpos$flag == F,]
dados_test$flag <- NULL

#install.packages('randomForest')
library(randomForest)
#
#install.packages('caret')
library(caret)

modelo_rf <- randomForest(classe ~ ., data = dados_treino)
modelo_rf
predicao = predict(modelo_rf, newdata = dados_test[,-12])
predicao
