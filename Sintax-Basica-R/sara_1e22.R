#Vetor
#tem que ser todos iguais
y = c(1,2,3)
x = c(1,2,3)
x+y

z=x/y
print(z)

z= c(TRUE, TRUE, TRUE)
y= c('sara','leo','douglas')
y[c(1,3)] #slice

y= c(y, 'a') #inserindo
rm(y, 'sara')
print(y)

y[1]='Iesb' #substituindo
print(y)
y['sara']='Iesb'
print(y)

z[-1]

n=c(1,2,3,4,5)
b=c(is.na(n))
b

!is.na(z) #is na negada



n[3:5]

length(y)+1



lista= list('sara', 1, 'augusto', 'gabriel')
lista[3]


#matriz

m = matrix(nrow= 2, ncol=2)
m
rownames(m) = c('Primeira', 'Segunda')
colnames(m) = c('A', 'B')
m[1,1] = 0
m[1,2]= 1
m[2,1]=2
m[2,2]=3
m
m[1:2, 1:2]

rownames(d) = c('Primeira', 'Segunda', 'terceira')
colnames(d) = c('A', 'B')
d= matrix(c(TRUE, 'dois', 4, 'seis', FALSE, 'gabriel'),nrow = 3, ncol=2)
d
typeof(d)

y=c(1,3)
y[c(1,3)]



m = matrix(data = c(TRUE, 'dois', 4, 'seis', FALSE, 'gabriel', "iesb", '10', 2019, "machine learning", "ia", "Big data",1,2,3,4),
                  nrow=4, ncol=4)

m[2:4, 2]
m[3, 2:4]
m[c(1,3),c(1,3)]
m[c(2,4),c(1,3,4)]
