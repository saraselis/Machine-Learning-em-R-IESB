

#### VETOR ####

## criando vetor
y <- c(TRUE, TRUE, FALSE, FALSE)
y

z <- c("SARAH", "Tracy","Jon")
z

n <- c(0,5,10)
n

## inserindo novo elemento em um vetor
z <- c(z,"annette")
z

## acessando valores dos vetores
y[1]

z[3]

## acessando sequência de valores dos vetores 
y[2:4]

z[1:3]

## acessando multiplo valores dos vetores 
y[c(1,3)]

z[c(2,4)]

## Deletando valor do vetor (mantendo o indice)
y[3] <- NA
y

z[1] <- NA
z

## Deletando valor do vetor (deletando o indice)
y <- y[-3] 
y

z <- z[-1]
z


#### MATRIZ ####

## criando uma matriz
m <- matrix(nrow = 2, ncol = 2)
m

m <- matrix(data = c(TRUE, "dois", 4, "seis", FALSE, "gabriel",
              "IESB", 10, 2019, "machine learning",
              "IA","Big data",1,2,3,5),
            nrow = 4, ncol = 4)
m



## acessando valores da matriz
m[3]

m[6]

m[1,2] ## linha x coluna

m[2,1] ## linha x coluna


## acessando sequencia de valores da matriz
m[2:4,2] ## linhas 2 a 4, coluna 2

m[3,2:4] ## linha 3, colunas 2 a 4


## acessando valores especificos da matriz
m[c(1,3),c(1,3)] ## linhas 1 e 3, colunas 1 e 3

m[c(2,4),c(1,3,4)] ## linhas 1 e 3, colunas 1 e 3


## acessando indices inexistentes 
m[5,5]


## Alterando valores
m[1,1] <- "IESB"
m

## Deletando valores
m[3,2] <- NA
m

## Deletando indices
m_2 <- m[-4,] ## excluindo linha inteira
m_2

m_2 <- m[,-2] ## excluindo coluna inteira
m_2

m_2 <- m[-4,-2] ## excluindo linha e coluna
m_2


#### LISTA ####

## criando lista
l <- list(1,"dois",FALSE)
l

##acessando valores
l[[1]]

l[[3]]

## alterando valores da lista

l[[2]] <- "alteração lista"
l

l[[2]][2] <- "novo valor"
l

## inserindo outros tipos de dados na lista

##inserindo um vetor na lista
l[[1]] <- c('vetor_1','vetor_2','vetor_3')
l

## acessando uma posição especifica do vetor dentro da lista
l[[1]][2]

## inserindo uma lista dentro da lista
l[[2]] <- list('lista_1','lista_2','lista_3','lista_4')
l

## acessando uma posição especifica da lista dentro da lista
l[[2]][4]

## inserindo uma matriz dentro da lista
l[[3]] <- matrix(nrow = 2,ncol = 3,data = c(1,2,3,4,5,6))
l

## acessando uma posição especifica da matriz dentro da lista
l[[3]][1,3]


## deletando indice da lista
l <- l[-2]
l


#### DATA FRAME ####

## criando dataframe
df <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
df

## acessando todas as linhas e uma colunas
df$x

## acessando uma linha e todas as colunas
df[3,]

## acessando todas as linhas e colunas especificas
df[, c("id","y")]

## acessando linhas e colunas específicas
df[c(1,5,10),c("id","y")]


## DELETANDO DADOS

## excluindo uma coluna inteira
df_2   <- df[,-3] ## excluindo pelo índice 

df_2   <- df ## criando uma cópia do dataframe
df_2$y <- NULL ## excluindo coluna atribuindo valor NULL para todas as linhas

## excluindo multiplas colunas
df_2 <- df[,c(-1,-3)] ## usando índice

df_2 <- df ## criando uma cópia do dataframe
df_2[,c('id','y')] <- NULL ## atribuindo valor NULL às colunas

## inserindo novos valores
df_2 <- df ## criando copia dataframe

index <- length(df_2$x) ## verificando qtd linhas do dataframe
index

df_2[index, ] <- c('a',11,22) ## inserindo novo registro

## inserindo novo registro com WARNING, porque a letra K
 # não estã no nível (levels) da coluna 'id'
df_2[index, ] <- c('k',11,22) 
                              

## excluindo linha específica
df_2 <- df[-5,]

## excluindo multiplas linhas
df_2 <- df[c(-1,-5,-10),]

## alterando tipo de dado na coluna
df_2$id <- as.character(df_2$id)



## selecionando(excluindo) linhas com condições
# igualdade
df_2 <- df[df$id == 'd', ]

# condição OR(OU)
df_2 <- df[(df$id == 'd') | (df$x == 7),]

# condição AND
df_2 <- df[(df$id == 'd') & (df$x == 7),]

df_2 <- df[(df$id == 'd') & (df$x == 4),]

# filtro com IN


