
## verificando diretório
getwd()

## definindo diretório
setwd("C:/Users/gabri/Documents/GitHub/ml_r_iesb")


#### importando dados CSV (função nativa) ####
dados <- read.csv(file = "dados.csv")

dados  <- read.csv(file = "dados.csv",sep = ';')
dados  <- read.csv(file = "dados.csv",sep = ';', header = F) ## INDICA QUE A BASE NÃO TEM CABEÇALHO
dados  <- read.csv(file = "dados.csv",sep = ';', nrows = 10) ## QUANTIDADE DE LINHAS QUE SERÃO CARREGADAS
dados2 <- read.csv(file = "dados.csv",sep = ';', nrows = 10, skip = 2) ## INDICA SE IRÁ PULAR ALGUMA LINHA
dados2 <- read.csv(file = "dados.csv",sep = ';', nrows = 10, stringsAsFactors = F) ## INDICA SE OS CAMPOS SERÃO STRING OU FACTOR
dados2 <- read.csv(file = "dados.csv",sep = ';', nrows = 10, encoding = "UTF-8") ## ENCODING RESOLVE PROBLEMA DE ACENTUAÇÃO

dados2 <- read.csv2(file = "dados.csv",nrows = 10, stringsAsFactors = F)

#### importando dados CSV (função fread do pacote data.table) ####
#install.packages('data.table')
library(data.table)

dados <- fread(input = 'dados.csv',stringsAsFactors = F)


#### EXPLORANDO BASE DADOS ####
## visualizanod os dados
View(dados)

## resumo da base de dados
str(dados)

## selecionando colunas
dados$language

dados[,c("id","language")]

## selecionando linhas
dados[1,]

dados[5,]

dados[c(1,5),]


## selecionando linhas com condições
dados[dados$id == 100,]
View(dados[dados$id == 100,])

#### CRIANDO NOVA BASE DE DADOS A PARTIR DE OUTRA ####

novo_df <- dados[dados$id == 142, ]
novo_df <- dados[seq(1,8), ]
novo_df <- dados[sample(11319,8), ]

#### SALVANDO DADOS CSV ####
write.csv(x = novo_df,file =  'novo_df.csv')
fwrite(novo_df, 'novo_df.csv')


#### COMPARANDO AS FUNÇÕES ####
system.time(
  dados <- read.csv2('dados.csv',stringsAsFactors = F,encoding = 'UTF-8')
)

system.time(
  dados2 <- fread('dados.csv',stringsAsFactors = F,encoding = 'UTF-8')
)
