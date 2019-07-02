#Verificando e setando o diretório
getwd()
setwd("C:/Users/TEMP/Documents/R")

#Importando o arquivo
df=read.csv(file = 'velocidades_2.csv', sep = ';', stringsAsFactors = FALSE, encoding = 'UTF-8')

#Análise exploratória
str(df)
summary(df)
head(df)

#backup do dataset
dados <- df

#Eliminando columa X
dados$X <- NULL
summary(dados)

#Convertendo os valores não numéricos para numéricos
dados$speed = as.numeric(dados$speed)
summary(dados)

#Trantando dados faltantes
dados <- dados[!is.na(dados$speed),] 

dados <- dados[!is.na(dados$dist),]
summary(dados)
dados

#Regressão Linear
?lm()
regression = lm(formula = dist ~ speed, data=dados)  
regression


#Importando novos dados
nova_vel = read.csv(file = 'novas_velocidade.csv', sep=',',stringsAsFactors = FALSE, encoding = 'UTF-8')
str(nova_vel)
summary(nova_vel)
head(nova_vel)

#excluindo x
nova_vel$X <- NULL

colnames(nova_vel) <- "speed"
resultados <- predict(object = regression, newdata = nova_vel)
resultados

nova_vel$prev <- resultados
