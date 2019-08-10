
#### PRINCIPAIS FUNÇÕES ESTATISTICA ####

## criando um vetor de 5 números, de 2.
numeros <- rep(x = 2,5)
numeros

## desvio padrão
sd(numeros)

## média
mean(numeros)

## mediana
median(numeros)

## máximo e mínimo
max(numeros)
min(numeros)

## resumo estatístico do vetor (não tem sd)
summary(numeros)

#### FUNÇÕES PARA GERAR NÚMEROS ####
seq(from = 1,to = 10,by = 1) ## cria um vetor sequencial de 1 a 10
sample(x = 5,size = 3)       ## cria um vetor com 3 números aleatórios entre 1 a 5 sem repetição

sample(x = 5,size = 6)
sample(x = 5,size = 6, replace = T) ## cria um vetor com 6 números aleatórios entre 1 a 5 com repetição




#### ATIVIDADE 1 ####
## Crie um vetor de tamanho 20 com números aleatórios entre 1 e 10. 
## E depois calcule media, mediana, máximo e mínimo 
## ATENÇÃO: EXECUTE O set.seed(234) ANTES

set.seed(234)

## gerando vetor de números
numeros <- sample(x = 10,size = 20,replace = T)
numeros

## calculando valores estatísticos
summary(numeros)



