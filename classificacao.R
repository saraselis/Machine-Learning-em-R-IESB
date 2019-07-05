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
mean(dados$alcohol, na.rm =T)
dados$alcohol = gsub(pattern= 'NA', replacement='10.48908', x=dados$citric.acid, ignore.case = FALSE)
dados$alcohol <- as.numeric(x = dados$alcohol)


dados[is.na(dados$alcohol),"alcohol"] - mean(dados$alcohol, na.rm =T)
