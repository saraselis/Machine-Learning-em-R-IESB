
## carregando pacotes
library(stringr)
library(dplyr)
library(data.table)

getwd()
#setwd("C:/Users/gabri/Documents/GitHub/ml_r_iesb")

## importaÃ§Ã£o dados
dados_vinhos <- data.table::fread("winequality.csv",stringsAsFactors = F)


###### explorando base de dados ####
summary(dados_vinhos)


## tabela de frequÃªncia
table(dados_vinhos$type)
table(dados_vinhos$citric.acid)
table(dados_vinhos$alcohol)

## grÃ¡fico de barra da tabela de frequencia
#barplot(table(dados_vinhos$type))
#barplot(table(dados_vinhos$alcohol))


###### pre-processamento dos dados ####

## corrigindo valores na coluna type
dados_vinhos$type <- gsub('0','Red',dados_vinhos$type)
dados_vinhos$type <- gsub('1','White',dados_vinhos$type)
table(dados_vinhos$type)

## corrigindo valores na coluna citric.acid
dados_vinhos$citric.acid <- gsub('\\,','.',dados_vinhos$citric.acid)
dados_vinhos$citric.acid <- as.numeric(dados_vinhos$citric.acid)


## convertendo para número coluna ALCOHOL
dados_vinhos$alcohol <- as.numeric(dados_vinhos$alcohol)

summary(dados_vinhos)

## substituindo NA pela média geral na coluna alcohol

dados_vinhos$alcohol_mean <- dados_vinhos$alcohol ## criando uma nova coluna (copia da alcohol)

dados_vinhos[is.na(dados_vinhos$alcohol_mean),"alcohol_mean"] <- mean(dados_vinhos$alcohol_mean, na.rm = T)
summary(dados_vinhos)

## substituindo NA pela média por tipo de vinha (type) na coluna alcohol

#dados_vinhos$nv <- dados_vinhos$alcohol
#dados_vinhos[is.na(dados_vinhos$nv),'nv'] <- 0
#summary(dados_vinhos$nv)

## calculando a média por tipo de vinho (type)
library(dplyr)
media_type <- dados_vinhos %>%
                group_by(type) %>%
                summarise(media = mean(alcohol,na.rm = T))

## substituindo valores NA para vinhos RED pela media 
dados_vinhos[(is.na(dados_vinhos$alcohol) ) & (dados_vinhos$type == 'Red'),'alcohol'] <- 
  media_type[media_type$type == 'Red','media']

## substituindo valores NA para vinhos WHITE  pela media 
dados_vinhos[(is.na(dados_vinhos$alcohol) ) & (dados_vinhos$type == 'White'),'alcohol'] <- 
  media_type[media_type$type == 'White','media']

summary(dados_vinhos$alcohol)

## convertendo coluna quality para 3 classes (0-ruim, 1-bom, 2-otimo)

## uma das opções para realizar a transformação (classe)
dados_vinhos$classe <- ifelse(dados_vinhos$quality < 5, 0,
                              ifelse(dados_vinhos$quality > 7, 2, 1))

table(dados_vinhos$classe)

###################### OPCIONAL ##################################################
## fazendo a mesma transformação, mas utilizando o pacote DPLYR (OPCIONAL)
dados_tres_clas <- dados_vinhos %>%
                    mutate(classe = ifelse(quality < 5, 0,
                                           ifelse(quality > 7, 2, 1)))

View(dados_tres_clas)

#################################################################################

## criando cópia 
dados_tres_clas <- dados_vinhos

## convertendo a coluna CLASSE em FACTOR (necessário porque algumas funções obrigam esse formato)
dados_tres_clas$classe <- as.factor(dados_tres_clas$classe)

summary(dados_tres_clas)

## excluindo colunas irrelevantes 
dados_tres_clas$type         <- NULL
dados_tres_clas$alcohol_mean <- NULL
dados_tres_clas$quality      <- NULL

#### CONSTRUINDO MODELO DE ML ####
library(caTools)

## dividindo base de dados em treino (80% TRUE) e teste (20% FALSE)
set.seed(2345)
div_valores <- sample.split(dados_tres_clas$classe,SplitRatio = 0.8)
table(div_valores)

dados_tres_clas$flag <- div_valores
  
dados_treino <- dados_tres_clas[dados_tres_clas$flag == T, ]
dados_teste  <- dados_tres_clas[dados_tres_clas$flag == F, ]
dados_treino$flag <- NULL
dados_teste$flag <- NULL

summary(dados_treino)
summary(dados_teste)

##### criando modelo ####
library(randomForest)
library(caret)

help(randomForest)

set.seed(2345)
## modelo de classificaÃ§Ã£o randomForest
modelo_rf <- randomForest(classe ~ ., data = dados_treino)#, importance = T)

## visualizando informações do modelo
modelo_rf

## executando o modelo na base de teste. É necessário fazer um sliece (-12) para excluir
 # a coluna CLASSE da base de teste, se não, o algoritmo utiliza essa coluna para fazer previsões
pred_rf   <- predict(modelo_rf, dados_teste[,-c(12)], type = 'class')
pred_rf
table(pred_rf)

## inserindo os resultados na base de teste para fazer uma visualização 
dados_teste$pred <- pred_rf

View(dados_teste)

## avaliando o modelo com matiz de confusão, acurárica, precision (sensitivity), recall (specificity)
atual     <- dados_teste$classe
predicted <- as.factor(pred_rf)

## salvando a matrix de confusão (confusion matrix) em um objeto
cof_matrix <- caret::confusionMatrix(predicted, atual)

## convertendo as métricas de avaliação em um data frame
metricas <- as.data.frame(cof_matrix$byClass)

##calculando média das métricas
mean(metricas[,'F1'])

#### FAZENDO NOVO PRE-PROCESSAMENTO DIVIDINDO A CLASSE EM APENAS 2 CATEGORIAS (CLASSIFICAÇÃO BINARIA)

### DUAS CLASSES (0-ruim, 1-bom)

dados_duas_clas <- dados_vinhos

dados_duas_clas$classe <- ifelse(dados_duas_clas$quality < 6, 0, 1)
dados_duas_clas$classe <- as.factor(dados_duas_clas$classe)

table(dados_duas_clas$classe)

dados_duas_clas$type         <- NULL
dados_duas_clas$alcohol_mean <- NULL
dados_duas_clas$quality      <- NULL

## dividindo base de dados em treino (80% TRUE) e teste (20% FALSE)
set.seed(2345)
div_valores_2 <- sample.split(dados_duas_clas$classe,SplitRatio = 0.8)
table(div_valores_2)

dados_duas_clas$flag <- div_valores_2

dados_treino_2      <- dados_duas_clas[dados_duas_clas$flag == T, ]
dados_teste_2       <- dados_duas_clas[dados_duas_clas$flag == F, ]
dados_treino_2$flag <- NULL
dados_teste_2$flag  <- NULL

## construindo modelo
modelo_rf_2 <- randomForest(classe ~ ., data = dados_treino_2, importance = T)

## testando modelo
pred_rf_2   <- predict(modelo_rf_2, dados_teste_2[,-12], type = 'class')

## avaliando modelo
conf_matrix_2 <- caret::confusionMatrix(pred_rf_2, dados_teste_2$classe )

conf_matrix_2$byClass
