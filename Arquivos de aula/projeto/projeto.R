
dados <- fread('G:/GitHub/ml_r_iesb/projeto/dataset.csv',stringsAsFactors = F)

summary(dados)

dados$V1 <- NULL

dados_limpos <- dados[dados$Species != 'n/d',]


dados_limpos$Sepal.Length <- gsub('\\,','.',dados_limpos$Sepal.Length)
dados_limpos$Sepal.Width  <- gsub('\\$','',dados_limpos$Sepal.Width)
dados_limpos$Petal.Length <- gsub('\\,','.',dados_limpos$Petal.Width)
dados_limpos$Petal.Length <- gsub('\\*','',dados_limpos$Petal.Length)
dados_limpos$Petal.Width  <- gsub('\\*','',dados_limpos$Petal.Width)

dados_limpos$Sepal.Length <- as.numeric(dados_limpos$Sepal.Length)
dados_limpos$Sepal.Width  <- as.numeric(dados_limpos$Sepal.Width)
dados_limpos$Petal.Length <- as.numeric(dados_limpos$Petal.Width)
dados_limpos$Petal.Length <- as.numeric(dados_limpos$Petal.Length)
dados_limpos$Petal.Width  <- as.numeric(dados_limpos$Petal.Width)

summary(dados_limpos)


table(dados_limpos$Species)
dados_limpos$Species <- gsub('_','',dados_limpos$Species)
dados_limpos$Species <- toupper(dados_limpos$Species)

table(dados_limpos$Species)

dados_limpos$Species <- as.factor(dados_limpos$Species)

#### CONSTRUINDO MODELO DE ML ####
library(caTools)
library(randomForest)

## dividindo base de dados em treino (80% TRUE) e teste (20% FALSE)
set.seed(2345)
div_valores <- sample.split(dados_limpos$Species,SplitRatio = 0.8)
table(div_valores)

dados_limpos$flag <- div_valores

dados_treino <- dados_limpos[dados_limpos$flag == T, ]
dados_teste  <- dados_limpos[dados_limpos$flag == F, ]
dados_treino$flag <- NULL
dados_teste$flag <- NULL


library(caret)

## modelo de classificaÃ§Ã£o randomForest
set.seed(2345)
modelo_rf <- randomForest(Species ~ ., data = dados_treino)

## visualizando informações do modelo
modelo_rf

## executando o modelo na base de teste. É necessário fazer um sliece (-12) para excluir
# a coluna CLASSE da base de teste, se não, o algoritmo utiliza essa coluna para fazer previsões
pred_rf   <- predict(modelo_rf, dados_teste[,-c(5)])
pred_rf
table(pred_rf)

## inserindo os resultados na base de teste para fazer uma visualização 
dados_teste$pred <- pred_rf

View(dados_teste)

## avaliando o modelo com matiz de confusão, acurárica, precision (sensitivity), recall (specificity)
atual     <- dados_teste$Species
predicted <- as.factor(pred_rf)

## salvando a matrix de confusão (confusion matrix) em um objeto
cof_matrix <- caret::confusionMatrix(predicted, atual)

cof_matrix

## convertendo as métricas de avaliação em um data frame
metricas <- as.data.frame(cof_matrix$byClass)

##calculando média das métricas
mean(metricas$Precision)
mean(metricas$Recall)
mean(metricas$F1)



#---------------------------------------------------------------------------------#

########################################## CLUSTER ################################

#---------------------------------------------------------------------------------#



