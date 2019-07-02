getwd()
setwd("C:/Users/1712082018/Documents/R_Sara_S")

dados=read.csv(file = 'dados_2.csv', sep = ',', stringsAsFactors = FALSE, encoding = 'UTF-8')
str(dados)
summary(dados)

d_2016 = dados[dados$anocalendario == 2016,]


DF_FEM = dados[dados$SexoConsumidor == 'F',]
DF_FEM

DF_UF = dados[dados$UF == 'DF' | dados$UF == 'GO' | dados$UF == 'CE',]
df_UF = dados[dados$UF %in% c('DF', 'GO', 'CE')]


aleat = sample(x = 50000,size = 10000)
aleat
df = data.frame(aleat, nrow(1:10000))
df

a=dados[sample(nrow(dados), 10000),]


linhas =sample(x=length(dados$anocalendario), size=10000)
dados_2 = dados[linhas,]
#write.csv(x=DF_FEM, file=('dados_fem.csv')
 
 
 
 #------------------------------------------------------------------#
 
 
dados = fread('dados_2.csv', encoding='UTF-8')

SUB_DADOS = dados[,c('anocalendario', 'UF', 'Atendida', 'SexoConsumidor')]
table(SUB_DADOS$UF) 
nomes = c('gabriel lima', 'analista de dados', 'brasília-DF', 'iesb -df', 'ciencia de dados')

gsub(x=nomes, pattern='dados', replacement = '\\*')
SUB_DADOS_uf = gsub(x= SUB_DADOS$UF, pattern = '*', replacement = '')
SUB_DADOS_uf = toupper(SUB_DADOS_uf)
table(sub_dados$uf)

tolower(nomes)
toupper(nomes) 
 
 
sub_dados_at = gsub(x= SUB_DADOS$Atendida, pattern ='s', replacement = 'SIM', ignore.case = T)
sub_dados_at = toupper(sub_dados_at) 
table(sub_dados_at) 


SUB_DADOS$nova_coluna = 'Na'       
SUB_DADOS$nova_coluna2 = 'Na'
SUB_DADOS$nova_coluna3= 'Na'
SUB_DADOS$nova_coluna3= 'NULL'

SUB_DADOS[,c('nova_coluna', 'nova_coluna2', 'nova_coluna3')] = NULL
