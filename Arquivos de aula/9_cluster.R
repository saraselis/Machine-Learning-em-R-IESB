# Clustering com K-Means

# Identificando segmentos de adolescentes
# Dataset com dados de 30.000 sobre uma pesquisas com adolescentes dos EUA 
# sobre interesses e redes sociais.

#library(dplyr)

setwd("G:/GitHub/ml_r_iesb")

# Carregando os dados
dados <- read.csv("dados_adolescentes.csv")
summary(dados)
head(dados) ## visualizando apenas os primeiros registros 
View(head(dados))

##### EXPLORAÇÃO DA BASE DE DADOS ####

# Verificando valores missing para variáveis relacionadas ao sexo 
table(dados$gender)
table(dados$gender, useNA = "ifany") ## visualizar a quantidade de valores NA

# Verificando valores missing para variáveis relacionadas a idade 
summary(dados$age)

plot(dados$age)

##### PRÉ-PROCESSAMENTO DOS DADOS ####
# Selecionando registros apenas entre 13 e 20 anos (Eliminando outliers na variável idade)
dados$age <- ifelse(dados$age >= 13 & dados$age < 20, dados$age, NA)
summary(dados$age)

# Atribuindo valores missing na variável sexo para o tipo "outros"
dados$female <- ifelse(dados$gender == "F" & !is.na(dados$gender), 1, 0)
table(dados$female)

dados$outros <- ifelse(is.na(dados$gender), 1, 0)

table(dados$outros)

# Verificando o resultado
table(dados$gender, useNA = "ifany")
table(dados$female, useNA = "ifany")
table(dados$outros, useNA = "ifany")

# Buscando a média de idade
mean(dados$age, na.rm = TRUE)

# Agregando os dados e calculando a média de idade por ano em que estev na escola
?aggregate
aggregate(data = dados, age ~ gradyear, mean, na.rm = TRUE)

# Cria um vetor com a média de idade por ano e substiu onde há valor NA
media_idade <- ave(dados$age, dados$gradyear, FUN = function(x) mean(x, na.rm = TRUE))

summary(dados$age)
dados$age   <- ifelse(is.na(dados$age), media_idade, dados$age) ## substituindo valores NA pela m�dia, na coluna AGE
summary(dados$age)


# Criando um vetor com os interesses de cada jovem selecionando as colunas da posição 5 até 40
colnames(dados)
interesses <- dados[,5:40]

# Normalizando os dados (jeito mais dificil, porque teria que fazer em todas as outras colunas)
interesses_norm <- interesses
interesses_norm$basketball <- scale(interesses$basketball)
interesses_norm$football   <- scale(interesses$football)
interesses_norm$soccer     <- scale(interesses$soccer)

# Normalizando os dados (jeito mais f�cil, todas as colunas s�o normalizadas de uma vez)
interesses_norm <- data.frame(scale(interesses[,]))


#### Criando modelo para cluster ####

# Criando o modelo
set.seed(2345)
?kmeans
dados_clusters <- kmeans(interesses_norm, 5)
print(dados_clusters)

# Verificando o tamanho dos clusters
dados_clusters$size

# Verificando o centro dos clusters
#dados_clusters$centers

# Aplicando o ID dos clusters ao dataframe original
dados_clusters$cluster
dados$cluster <- dados_clusters$cluster
head(dados)

# Verificando os 5 primeiros registros
dados[1:5, c("cluster", "gender", "age", "friends")]

# Média de idade por cluster
aggregate(data = dados, age ~ cluster, mean)

# Proporção de mulheres por cluster
aggregate(data = dados, female ~ cluster, mean)

# Média de número de amigos por cluster
aggregate(data = dados, friends ~ cluster, mean)


###### Visualização dos clusters #### 

# Pacotes
#install.packages("fpc")
#library(cluster)
library(fpc)

# Visualizando os clusters
?plotcluster
#plotcluster(interesses, dados$cluster)
plotcluster(interesses_norm, dados$cluster)
