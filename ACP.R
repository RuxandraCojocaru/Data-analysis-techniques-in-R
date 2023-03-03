#ACP
library(readxl)
library(corrplot)
library(ggplot2)
library(FactoMineR)
library(factoextra)

#Reading data
proiect <- read_excel("D:/Ruxi/Facultate/GitHub/Data_analysis_R/NoOutliers.xlsx")
View(proiect)
date<-proiect[,2:10]


####Statistici Descriptive
windows()
par(mfrow=c(3,4))
for(i in 1:ncol(date)){
  print(boxplot(date[,i], main=paste("Boxplot ", names(date)[i]), xlab=names(date)[i], col=i+1))
}

hist(date$ExportTech , main="Histograma ExportTech", col="pink")
hist(date$UrbanPop , main="Histograma UrbanPopulation", col="green")

windows()
plot(date_std$IntelectProp,date_std$GDP,  col=c("red","green"), main="Reprezentare dependenta")
abline(lm(date_std$IntelectProp~date_std$GDP)) #adauga dreapta de regresie pe grafic

summary(date$TechValue)
summary(date$ExportTech)


###Standardizare date si matrice de corelatie
date_std=scale(date, scale = TRUE)
date_std=data.frame(date_std)

matr <- cor(date_std)
windows()
corrplot(matr, method="square") 


##### ACP
pca=princomp(date_std, cor=TRUE)
pca

#Calculez val proprii (varianta ) fiecarei comp princip
sdev=pca$sdev
valp=sdev*sdev
valp

#Determin procentul informational retinut de fiecare CP (componenta principala)
procent_info=valp*100/10
procent_info

#Procentul informational cumulat
procent_cumulat=cumsum(procent_info)
procent_cumulat
X=round(data.frame(sdev, valp, procent_info, procent_cumulat), 4)
X # => 3 components

scree_plot=prcomp(date_std)
plot(scree_plot, type="l", main="Scree plot")

### Determin vectorii proprii (loadings)
a=pca$loadings
a
write.table(round(a,3))

#valorile proprii ale matricei de covarianta
eigen(cov(date_std))$values
round(eigen(cov(date_std))$vectors,3)

#Determin scoruruile principale, adica coord. tarilor in noile axe
c=pca$scores[,1:3]
rownames(c)=proiect$'Country'
round(c,3)


#Calculez matricea factor
matr_factor=cor(date_std, c)
round(matr_factor,3)
windows()
corrplot(matr_factor, method="square")



##Reprezentarea tarilor in spatiul indicat de primele 2 CP
c2=data.frame(c)
dev.new()
plot(c2[,1],c2[,2], main="plot componente w1 si w2",xlab="w1", ylab="w2")
text(c2[,1],c2[,2], labels=rownames(c2), col="red", pos=3, cex=0.7)

c2=data.frame(c)
dev.new()
plot(c2[,1],c2[,3], main="plot componente w2 si w3",xlab="w2", ylab="w3")
text(c2[,1],c2[,3], labels=rownames(c2), col="red", pos=3, cex=0.7)

ggplot(c2, aes(x=c2[,2],y=c2[,3])) + geom_point(shape=16, size=4, col="red")+
  geom_text(label=rownames(c2),vjust=0,hjust=0,size=4)+
  labs(y = "Componenta 3", x = "Componenta 2")


##Reprezentari ale variabilelor in cadrul componentelor
biplot(c2[,1:2],pca$loadings[,1:2],cex=c(0.6,0.9))

cp=PCA(date_std)
summary(cp)

cp$var$contrib 

fviz_pca_var(pca, col.var="contrib", gradient.col=c("#00AFBB","#E7B800","#FC4E07"), repel=TRUE)
