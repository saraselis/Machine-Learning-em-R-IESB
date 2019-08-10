# http://www.sthda.com/english/articles/40-regression-analysis/166-predict-in-r-model-predictions-and-confidence-intervals/
# https://www.datacamp.com/community/tutorials/linear-regression-R#fit


##### carregando dados_2 #####
dados <- read.csv2('velocidades_2.csv',stringsAsFactors = F)

## criando cópia da base de dados_2
dados_2 <- dados

##### EXPLORANDO dados_2 ####
View(dados_2)

## excluindo colunas irrelevantes
dados_2$X <- NULL

## resumo da base de dados_2
summary(dados_2)

## convertendo string em número
dados_2$speed <- as.numeric(dados_2$speed)

## filtrando registros NA (excluindo)
dados_2 <- dados_2[!is.na(dados_2$speed),]


## visualizando dados_2
plot(dados_2)

## verificando a correlaÃ§Ã£o entre os dados_2
cor(dados_2)
cor(dados_2$speed,dados_2$dist)


##### CONSTRUINDO MODELO (LM) #####
?lm()

modelo_lm <- lm(formula = dist ~ speed, data = dados_2)

## verificando modelo
modelo_lm


## prevendo novos valores
novas_velocidades <- read.csv('novas_velocidades.csv')
View(novas_velocidades)

## excluindo coluna irrelevante
novas_velocidades$X <- NULL

## predição com erro. Os nomes das colunas devem ser exatamente iguais ao que o modelo foi treinado
predict_lm <- predict(modelo_lm, newdata = novas_velocidades)

## alterar o nome da coluna
colnames(novas_velocidades)
colnames(novas_velocidades) <- 'speed'


## prevendo valores
predict_lm <- predict(modelo_lm,newdata = novas_velocidades)
predict_lm

## inserindo resultados ao dataframe
novas_velocidades$pred <- predict_lm

##################### PODE CRIAR UM NOVO DATAFRAME COM OS RESULTADOS (OPCIONAL) ######################
## convertendo para data.frame (tabela)
predict_lm <- data.frame(velocidade = novas_velocidade$speed,
                         dist_parada = predict_lm)
View(predict_lm)

######################################################################################################


## visualizando modelo RL e valores previstos
library(ggplot2)
ggplot(dados_2, aes(speed, dist)) +
  geom_point() +
  stat_smooth(method = lm) + 
  geom_point(data = novas_velocidades, aes(speed,pred,color = 'red'),size = 3)
  

#### AVALIZANDO O MODELO ####

## será avaliado as métricas p-value e R² 
summary(modelo_lm)




