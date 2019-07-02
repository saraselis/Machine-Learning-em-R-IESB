l = list(1,2,3,4)
l[[3]] = m 
l

m = matrix(data = c(TRUE, 'dois', 4, 'seis', FALSE, 'gabriel', "iesb", '10', 2019, "machine learning", "ia", "Big data",1,2,3,4),
           nrow=4, ncol=4)

a = list(1,2,3,4)
append(a, m, after=2)
a

#append(x, values, after = length(x))


l[[3]][2,3] #acessar linha 2, coluna 3 da matriz

l[[3]][c(2,4), c(1:3)]
l[[3]][c(2,4),1:3]

index = c(1,5,10)
index
m[index]
#---------------


df = data.frame(id=letters[1:10], x=1:10, y=11:20)

df
#factory valores categóricos distintos
df['x']
df['y']
df['id']

df[8,]
df[6,1:2]
df$x

letters

df[c('id','y')]
df[,c(1,3)] #conveção
df[,c('id','y')] #convenção

df[c(1,5,10), c('y','x')]

df_y = df[c('y')[-1]] #selecionando y
df_y

df_s_y = df[,-3]
df_s_y$y = NULL

df_2= df[,c(-3,-1)]
df_2=df['x'] 
df_2[,c('y','id')] = NULL
df_2 = df.data_frame

df_5= df[c(5),c(1:3)] #guarda só a linha 5
df_5 = df[-5,] #apaga toda a linha 5
df_5 = df[-c(1, 5,10),]
df_5
df

df_2= df[-c(1:5),]
row.names(df_2) = 1:length(df_2$id) #recriando indices
df_2

df[df$id =='d',]
