#ACP

library(readxl)
proiect <- read_excel("D:/Ruxi/Facultate/GitHub/Data_analysis_R/NoOutliers.xlsx")
View(proiect)

date<-proiect[,2:11]

matr <- cor(date)
library(corrplot) 
windows()
corrplot(matr, method="square") 


windows()
par(mfrow=c(3,4))
for(i in 1:ncol(date)){
  print(boxplot(date[,i], main=paste("Boxplot ", names(date)[i]), xlab=names(date)[i], col=i+1))
}

library(moments)
moments::skewness(date$UrbanPop)


####Statistici Descriptive
hist(date$ExportTech , main="Histograma ExportTech", col="pink")
hist(date$UrbanPop , main="Histograma UrbanPopulation", col="green")

summary(date$TechValue)
summary(date$ExportTech)


install.packages("sp")
library(sp)
install.packages("cluster")
library(cluster)
install.packages("raster")
library(raster)


n<-matrix(nrow=2, ncol=4)

n[1,1]<-cv(date$TechValue)/2
n[1,2]<-sd(date$TechValue)
n[1,3]<-var(date$TechValue)
n[1,4]<-mean(date$TechValue)

n[2,1]<-cv(date$ExportTech)
n[2,2]<-sd(date$ExportTech)
n[2,3]<-var(date$ExportTech)
n[2,4]<-mean(date$ExportTech)

row.names<-c("TechValue","ExportTech")
col.names<-c("coeficient de variatie","abatere standard", "variatie", "medie")
dimnames(n)<-list(row.names,col.names)

options(scipen=99)
View(as.matrix(n))


###Grafice
date_std=scale(date, scale = TRUE)
date_std=data.frame(date_std)

windows()
plot(date_std$IntelectProp,date_std$GDP,  col=c("red","green"), main="Reprezentare dependenta")
abline(lm(date_std$IntelectProp~date_std$GDP)) #adauga dreapta de regresie pe grafic

windows()
plot(date_std$Journals, date_std$IntelectProp, col=c("red","green"), main="Reprezentare dependenta")
abline(lm(date_std$Journals~date_std$IntelectProp)) #adauga dreapta de regresie pe grafic


#Matricea de corelatie
matr <- cor(date_std)
library(corrplot) 
windows()
corrplot(matr, method="square") 


##### ACP
setNou=cbind(proiect[,2:8],proiect[,10:11])

date_std=scale(setNou, scale = TRUE)
date_std


pca=princomp(date_std, cor=TRUE)
pca

sdev=pca$sdev
#Calculez val proprii (varianta ) fiecarei comp princip
valp=sdev*sdev
valp

#Determin procentul informational retinut de fiecare CP (componenta principala)
procent_info=valp*100/9
procent_info
#Procentul informational cumulat
procent_cumulat=cumsum(procent_info)
procent_cumulat

X=round(data.frame(sdev, valp, procent_info, procent_cumulat), 4)
X


scree_plot=prcomp(date_std)
plot(scree_plot, type="l", main="Scree plot")

### Determin vectorii proprii (loadings)
a=pca$loadings
a
write.table(round(a,3))


#valorile proprii ale matricei de covarianta
eigen(cov(date_std))$values
round(eigen(cov(date_std))$vectors,3)

#Determin scoruruile principale
c=pca$scores[,1:3]
rownames(c)=proiect$'Country'
round(c,3)
#Scoruruile principale constituie coord. intreprinderilor in noile axe (date de CP)
round(date_std,3)
round(cor(c),5)


#Calculez matricea factor
matr_factor=cor(date_std, c)
round(matr_factor,3)
library(corrplot)
windows()
corrplot(matr_factor, method="square")



dev.new()
cerc=seq(0,2*pi, length=100)
plot(cos(cerc),sin(cerc), type="l",col="blue",xlab="w1", ylab="w2")
text(matr_factor[,1],matr_factor[,2],rownames(matr_factor),col="red",cex=0.7)

##Reprezentarea tarilor in spatiul indicat de primele 2 CP
c2=data.frame(c)
dev.new()
plot(c2[,1],c2[,2], main="plot componente w1 si w2",xlab="w1", ylab="w2")
text(c2[,1],c2[,2], labels=rownames(c2), col="red", pos=3, cex=0.7)

c2=data.frame(c)
dev.new()
plot(c2[,1],c2[,3], main="plot componente w2 si w3",xlab="w2", ylab="w3")
text(c2[,1],c2[,3], labels=rownames(c2), col="red", pos=3, cex=0.7)

installed.packages(ggplot2)
library(ggplot2)
ggplot(c2, aes(x=c2[,1],y=c2[,2])) + geom_point(shape=16, size=4, col="red")+
  geom_text(label=rownames(c2),vjust=0,hjust=0,size=4)


biplot(c2[,1:2],pca$loadings[,1:2],cex=c(0.6,0.9))
install.packages("FactoMineR")
library(FactoMineR)

cp=PCA(date_std)
summary(cp)

cp
round(cp$var$cos2,3)
cp$var$contrib 

install.packages("factoextra")
library(factoextra)
fviz_pca_var(pca, col.var="contrib", gradient.col=c("#00AFBB","#E7B800","#FC4E07"), repel=TRUE)
