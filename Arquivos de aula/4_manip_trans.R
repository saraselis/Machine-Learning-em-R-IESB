library(data.table)

getwd()

## importando os dados
dados <- fread('dados_2.csv',stringsAsFactors = F,encoding = 'UTF-8')

#### EXPLORANDO A BASE DE DADOS ####

## descriÃ§Ã£o dos dados (quantidade registros, colunas, nomes, tipos )
str(dados)

## quantidade de registros e colunas
dim(dados)

## resumo dos dados 
summary(dados)


#### MANIPULANDO/TRANSFORMANDO DADOS ####

colnames(dados) ## listando o nome das colunas

## criando sub conjunto de dados
sub_dados <- dados[,c('anocalendario', 'UF', 'Atendida', 'SexoConsumidor')]

## tabela de frequencia (count)
table(sub_dados$SexoConsumidor)

## transformando coluna SexoConsumidor
sub_dados$SexoConsumidor <- gsub('F','Femino',sub_dados$SexoConsumidor)
table(sub_dados$SexoConsumidor)

sub_dados$SexoConsumidor <- gsub('M','Masculino',sub_dados$SexoConsumidor)
table(sub_dados$SexoConsumidor)

## transformando coluna 
sub_dados$Atendida <- gsub('n','Não',sub_dados$Atendida,ignore.case = T)
table(sub_dados$Atendida)

sub_dados$Atendida <- gsub('s','Sim',sub_dados$Atendida,ignore.case = T)
table(sub_dados$Atendida)



# criar nova coluna
sub_dados$nova_coluna <- NA
str(sub_dados)

sub_dados$nova_coluna <- runif(length(sub_dados$nova_coluna),min = 0,max = 100)
summary(sub_dados$nova_coluna)

##arredondando casas decimais
sub_dados$nova_coluna <- round(x = sub_dados$nova_coluna,digits = 2)
summary(sub_dados$nova_coluna)

## arredondando para número inteiro
sub_dados$nova_coluna <- round(x = sub_dados$nova_coluna)
summary(sub_dados$nova_coluna)

sub_dados$nova_coluna <- as.integer(sub_dados$nova_coluna)
summary(sub_dados$nova_coluna)

# ELIMINAR COLUNA
sub_dados$nova_coluna <- NULL
str(sub_dados)


