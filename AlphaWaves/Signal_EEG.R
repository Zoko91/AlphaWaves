dataSet = read.csv(file="dataset.csv")

dictSuj = c('Sujet1_F','Sujet1_O','Sujet2_F','Sujet2_O','Sujet3_F','Sujet3_O','Sujet4_F','Sujet4_O','Sujet5_F','Sujet5_O','Sujet6_F','Sujet6_O','Sujet7_F','Sujet7_O','Sujet8_F','Sujet8_O', 'Sujet9_F','Sujet9_O', 'Sujet10_F','Sujet10_O', 'Sujet11_F','Sujet11_O', 'Sujet12_F','Sujet12_O', 'Sujet13_F','Sujet13_O', 'Sujet14_F','Sujet14_O', 'Sujet15_F','Sujet15_O', 'Sujet16_F','Sujet16_O', 'Sujet17_F','Sujet17_O', 'Sujet18_F','Sujet18_O','Sujet19_F','Sujet19_O', 'Sujet20_F','Sujet20_O')
dict = c('FP1','FP2','FC5','FC6','FZ','T7','CZ','T8','P7','P3','PZ','P4','P8','O1','Oz','O2')

for (i in 1:40){
  colnames(dataSet)[i] <- dictSuj[i]
}
for (j in 1:16){
  rownames(dataSet)[j] <- dict[j]
}

#Étude intra-individuel -> Les colonnes 2x2
#Sujet 1 - Fermé
#plot first line
plot(dataSet[,7], xaxt="n", type='p', col="blue", xlab = 'Électrodes', ylab = "Moyenne énergie entre 8 et 12Hz")
axis(1, at=1:16, labels=row.names(dataSet))

#add second line to plot
lines(dataSet[,8], type="p", col="orange")
abline(h=c(mean(dataSet[,7]), mean(dataSet[,6])), col=c("blue", "orange"), lty=c(2,2))
legend(1,140,
       legend=c("Fermés", "Ouverts"),
       col=c("blue", "orange"), lty=c(1,1))


for(i in 1:20){
  test = which(dataSet[,2*i-1] > mean(dataSet[,2*i-1]))
  print(test)
}

vals =c(7,10,11,14,15,4,7,10,11,12,13,14,15,16,7,9,10,11,12,14,15,16,3,6,7,9,10,11,12,14,15,16,4,9,10,11,12,13,14,15,16,3,4,6,7,11,14,15,16,7,9,10,12,13,14,15,16,4,7,9,11,12,13,14,4,6,7,9,11,12,13,15,7,9,10,11,13,14,15,16,3,9,10,11,12,14,15,7,9,10,11,12,14,15,4,10,11,12,13,14,15,4,5,10,11,12,14,15,3,4,5,6,7,9,10,11,12,15,5,7,9,12,13,14,15,16,7,10,11,12,13,14,15,16,7,9,10,12,13,14,15,16,8,9,10,11,12,13,14,15,16,4,11,12,13,14,16)
plot((table(vals)),xaxt='n',ylab="Nombre d'occurences", xlab='Electrodes')
abline(h=mean(vals),col="red")
axis(1, at=1:16, labels=row.names(dataSet))

for(i in 1:20){
  indice = 2*i-1
  test(i)= mean(dataSet[c(5,7,8,9,10,11,12,13,14,15),indice])
  print(mean(dataSet[c(5,7,8,9,10,11,12,13,14,15),indice]))
}
for(i in 1:20){
  indice = 2*i
  print(mean(dataSet[c(5,7,8,9,10,11,12,13,14,15),indice]))
}
moyenneOuvert = c(30.088,69.6039,62.2371,73.2143,80.9628,64.6059,106.776,72.2958,39.6807,60.3984,46.8422,103.0094,62.8306,90.5166,100.3188,75.8098,142.1024,66.0854,28.9743,59.4847)
moyenne = c(78.7748,207.237,128.0322,99.5003,161.9392,94.1402,191.724,160.4261,56.9922,104.3499,98.7529,211.711,90.8902,152.4698,124.6171,112.6525,286.478,149.6503,38.5281,78.0732)
plot(moyenne, ylab="Energie moyenne",xlab="Individus",main="Etude de l'energie moyenne des électrodes cibes en fonction des individus",col="blue",xaxt='n',type='o')
lines(moyenneOuvert,type='o',col="orange")
axis(1,at=1:20)
legend(1,280,
       legend=c("Fermés", "Ouverts"),
       col=c("blue", "orange"), lty=c(1,1))
abline(h=(mean(moyenne)-sd(moyenne)),col='red')

